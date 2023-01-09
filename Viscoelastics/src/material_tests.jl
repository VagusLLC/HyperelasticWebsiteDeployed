export ViscousUniaxialTest, ViscousBiaxialTest, predict
struct ViscousDataEntry{T}
    λ::Vector{T}
    s::Vector{T}
    t::T
end

struct ViscousDMAEntry{T}
    f::Vector{T}
end
"""
ViscousDynamicMechanicalAnalysisTest

"""
struct ViscousDynamicMechanicalAnalysisTest <: NonlinearContinua.AbstractMaterialTest
    data::StructVector
    incompressible::Bool
    name::String
    frequency::Number
    amplitude::Number
end

"""
ViscousUniaxialTest(λ₁, s₁, t; name, incompressible = true)
- Note: This does assumes an incompressible material.
"""
struct ViscousUniaxialTest <: NonlinearContinua.AbstractMaterialTest
    data::StructVector
    incompressible::Bool
    name::String
    function ViscousUniaxialTest(λ₁, s₁, t; name, incompressible=true)
        @assert length(λ₁) == length(s₁) == length(t) "Inputs must be the same length"
        if incompressible
            λ₂ = λ₃ = @. sqrt(1 / λ₁)
        else
            λ₂ = λ₃ = Vector{eltype(λ₁)}(undef, length(λ₁))
        end
        λ = collect.(zip(λ₁, λ₂, λ₃))
        s = collect.(zip(s₁))
        data = StructArray{ViscousDataEntry}((λ, s, t))
        new(data, incompressible, name)
    end
    function ViscousUniaxialTest(λ₁, t; name, incompressible=true)
        @assert length(λ₁) == length(t) "Inputs must be the same length"
        if incompressible
            λ₂ = λ₃ = @. sqrt(1 / λ₁)
        else
            λ₂ = λ₃ = Vector{eltype(λ₁)}(undef, length(λ₁))
        end
        λ = collect.(zip(λ₁, λ₂, λ₃))
        s = collect.(zip(Vector{eltype(λ₁)}(undef, length(λ₁))))
        data = StructArray{ViscousDataEntry}((λ, s, t))
        new(data, incompressible, name)
    end
end

struct ViscousBiaxialTest <: NonlinearContinua.AbstractMaterialTest
    data::StructVector
    incompressible::Bool
    name::String
    function ViscousBiaxialTest(λ₁, λ₂, s₁, s₂, t; name, incompressible=true)
        if incompressible
            λ₃ = @. 1 / λ₁ / λ₂
        else
            λ₃ = Vector{promote_type(eltype(λ₁), eltype(λ₂))}(undef, length(λ₁))
        end
        λ = collect.(zip(λ₁, λ₂, λ₃))
        s = collect.(zip(s₁, s₂))
        data = StructArray{ViscousDataEntry}((λ, s, t))
        new(data, incompressible, name)
    end
    function ViscousBiaxialTest(λ₁, λ₂, t; name, incompressible=true)
        if incompressible
            λ₃ = @. 1
        else
            λ₃ = Vector{promote_type(eltype(λ₁), eltype(λ₂))}(undef, length(λ₁))
        end
        λ = collect.(zip(λ₁, λ₂, λ₃))
        s = collect.(zip(Vector{eltype(λ₁)}(undef, length(λ₁))))
        data = StructArray{ViscousDataEntry}((λ, s, t))
        new(data, incompressible, name)
    end
end

function predict(ψ::AbstractViscousModel, data::ViscousUniaxialTest, p)
    history = MaterialHistory([data.data[1].λ], [data.data[1].t - 1])
    s = []
    if data.incompressible
        for entry in data.data
            push!(history.value, entry.λ)
            push!(history.time, entry.t)
            push!(s, SecondPiolaKirchoffStressTensor(ψ, history, p))
        end
    else
        function fit_λ₂(u, p)
            (; history, ps) = p
            history.value[end][2] = history.value[end][3] = u[1]
            σ = CauchyStressTensor(ψ, history, ps)
            return [abs(σ[2])]
        end
        nprob = NonlinearProblem(fit_λ₂, [history.value[1][1]], (history=history, ps=p))
        for entry in data.data
            push!(history.value, entry.λ)
            push!(history.time, entry.t)
            nprob = remake(nprob,
                u0=[sqrt(1 / history.value[end][1])],
                p=(history=history, ps=p)
            )
            solve(nprob, NLSolveJL())
            push!(s, SecondPiolaKirchoffStressTensor!(ψ, history, p))
        end
    end
    λ₁ = getindex.(data.data.λ, 1)
    λ₃ = getindex.(data.data.λ, 3)
    s₁ = getindex.(s, 1)
    s₃ = getindex.(s, 3)
    s₁ = s₁
    s₃ = s₃
    Δs₁ = @. s₁ - s₃ * λ₃ / λ₁
    t = data.data.t
    result = ViscousUniaxialTest(λ₁, Δs₁, t, name=data.name, incompressible=data.incompressible)
    return result
end

function predict(ψ::AbstractViscousModel, data::ViscousBiaxialTest, p)
    history = MaterialHistory([data.data[1].λ], [data.data[1].t])
    s = similar(data.data.s)
    # if data.incompressible
    for (i, entry) in enumerate(data.data)
        push!(history.value, entry.λ)
        push!(history.time, entry.t)
        s[i] = SecondPiolaKirchoffStressTensor(ψ, history, p)
    end
    # else
    #     function fit_λ₂(u, p)
    #         (; history, ps) = p
    #         history.value[end][2] = u[1]
    #         σ = CauchyStressTensor(ψ, history, ps)
    #         return [abs(σ[3])]
    #     end
    #     nprob = NonlinearProblem(fit_λ₂, [1 / history.value[1][1] / history.value[1][2]], (history=history, ps=p))
    #     for (i, entry) in enumerate(data)
    #         push!(history.value, entry.λ)
    #         push!(history.time, entry.t)
    #         nprob = remake(nprob,
    #             u0=[1 / history.value[1][1] / history.value[1][2]],
    #             p=(history=history, ps=p)
    #         )
    #         solve(nprob, NewtonRaphson())
    #         s[i] = SecondPiolaKirchoffStressTensor!(ψ, history, p)
    #     end
    # end
    return s
end

function ViscousParameterCalibration(ψ::AbstractViscousModel, tests::Vector{<:NonlinearContinua.AbstractMaterialTest}, p₀::ComponentVector;
    viscous_only=false, adtype=Optimization.AutoForwardDiff(), loss=L2DistLoss())

    if viscous_only
        hyperelastic_ps = p₀.hyperelastic
        function f(viscous_ps, (; ψ, tests, he_params))
            ŷ = predict(ψ, tests, (viscous=viscous_ps, hyperelastic=hyperelastic_ps))
            ŝ = getfield.(StructArrays.components.(getfield.(ŷ, :data)), :s)
            s = getfield.(StructArrays.components.(getfield.(tests, :data)), :s)
            ŝ = map(i -> vcat(ŝ[i]...), eachindex(ŝ))
            s = map(i -> vcat(s[i]...), eachindex(s))
            nmae = map(i -> value(loss, s[i], ŝ[i], AggMode.Mean()), eachindex(ŝ))
            return mean(nmae)
        end
        func = OptimizationFunction(f, adtype)
        prob = OptimizationProblem(func, p₀[:viscous], (ψ=ψ, tests=tests, he_params=hyperelastic_ps))
    else
        function g(model_parameters, (; ψ, tests))
            ŷ = predict(ψ, tests, model_parameters)
            ŝ = getfield.(StructArrays.components.(getfield.(ŷ, :data)), :s)
            s = getfield.(StructArrays.components.(getfield.(tests, :data)), :s)
            ŝ = map(i -> vcat(ŝ[i]...), eachindex(ŝ))
            s = map(i -> vcat(s[i]...), eachindex(s))
            nmae = map(i -> value(loss, s[i], ŝ[i], AggMode.Mean()), eachindex(ŝ))
            return mean(nmae)
        end
        func = OptimizationFunction(g, adtype)
        prob = OptimizationProblem(func, p₀, (ψ=ψ, tests=tests))
    end
    return prob
end
