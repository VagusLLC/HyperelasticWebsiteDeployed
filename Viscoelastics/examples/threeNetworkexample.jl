using Hyperelastics
using Viscoelastics
using ComponentArrays
using NonlinearSolve, SciMLNLSolve
using CairoMakie
##
networks = Dict(
    :A => ParallelNetworkBranch(
        GeneralCompressible(EdwardVilgis()),
        flow=PowerFlow(),
    ),
    :B => ParallelNetworkBranch(
        GeneralCompressible(ArrudaBoyce()),
        flow=Viscoelastics.PowerFlow(),
    ),
    # :C => ParallelNetworkBranch(
    #     GeneralCompressible(ArrudaBoyce()),
    #     flow=Viscoelastics.PowerFlow(),
    # ),
    # :D => ParallelNetworkBranch(
    #     GeneralCompressible(Gent()),
    # )
)

##
function uniaxial_stress_visco(ψ, time_vec, stretch_vec, ps)
    stress = Vector{Float64}[]
    λ2_2 = 1.0
    for (t, λ1) in zip(time_vec, stretch_vec)
        @show t, λ1
        # push!(history.value, [λ1, 0.0, 0.0])
        # push!(history.time, t[i])
        function find_λ₂(λ2, p)
            # history.value[end][2] = history.value[end][3] = u[1]
            σ = CauchyStressTensor(ψ, (t=t, F=[λ1, λ2[1], λ2[1]]), p)
            return [abs(σ[3])]
        end
        u0 = [λ2_2]
        prob = NonlinearProblem(find_λ₂, u0, ps)
        sol = solve(prob, NewtonRaphson())
        λ2_2 = sol.u[1]
        # history.value[end][2] = history.value[end][3] = λ2_2
        res = CauchyStressTensor!(ψ, (t=t, F=[λ1, λ2_2, λ2_2]), ps)
        push!(stress, res)
    end
    return stress
end
##
## Create the experimental test
ψ = GeneralParallelNetworkModel(networks)
N = 4000
t = range(0, 10.0, length=N)[2:end]
λ = exp.((sin.(5*t) .* 1.5))[2:end]
plot(t, λ)
function disp(t)
    λmax = 4.0
    λmin = 1.0
    λ̇ = 1.0
    t_half = (λmax - λmin) / λ̇
    iseven(div(t, t_half)) ? λmin + λ̇ * mod(t, t_half) : (λmax) - λ̇ * mod(t, t_half)
end
# λ = exp.((sin.(2.0*t).*1.5))[2:end]
λ = disp.(t)[2:end]
ps = ComponentVector(
    A=(
        hyperelastic=(
            ψ=(
                Ns=0.2,
                Nc=0.2,
                α=0.01,
                η=0.05
            ),
            κ=10.0
        ),
        flow=(
            τ̂=10.0,
            a=5.0,
            m=1.2,
        ),
    ),
    B=(
        hyperelastic=(
            ψ=(
                μ=0.5,
                N=100.0
            ),
            κ=0.1
        ),
        flow=(
            τ̂=2.0,
            a=0.5,
            m=1.1,
        ),
    ),
)
σ̂ = uniaxial_stress_visco(ψ, t, λ, ps)
lines(λ, getindex.(σ̂, 1), label="Bergstrom")
current_figure()
##
σ̂₁ = getindex.(σ̂, 1)
σ̂₁_max = maximum(σ̂₁)
σ̂₁_min = minimum(σ̂₁)
σ̂₁_norm = @. (σ̂₁ - σ̂₁_min) / (σ̂₁_max - σ̂₁_min)
λ₁_norm = @. λ / exp(1.5)
lines(t[1000:1100], λ₁_norm[1000:1100], label="λ")
lines!(t[1000:1100], σ̂₁_norm[1000:1100], label="σ")
axislegend()
current_figure()
