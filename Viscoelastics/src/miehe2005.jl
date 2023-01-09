export Miehe2005

struct ε{T,S}
    f::T
    c::S
end

"""
Miehe2005

- Arguments
    - ε₀f = 0.0
    - ε₀c = 0.0
    - t₀  = 0.0
    - s   = 5
    - hyperelastics (default = NonaffineMirosphere())
    - integrator = SimpleATsit5() [Any SciMLBase.AbstractODEAlgorithm, see DifferentialEquations.jl for further options.]

- Parameters
    - hyperelastic (default = NonaffineMicrosphere())
        - μ
        - N
        - p
        - U
        - q
    - μ
        - f⃗
        - c⃗
    - τ
        - f⃗
        - c⃗
    - δ
        - f⃗
        - c⃗

> Miehe C, Göktepe S. A micro–macro approach to rubber-like materials. Part II: The micro-sphere model of finite rubber viscoelasticity. Journal of the Mechanics and Physics of Solids. 2005 Oct 1;53(10):2231-58.
"""
struct Miehe2005 <: AbstractViscousModel
    hyperelastic::Hyperelastics.AbstractHyperelasticModel
    r⃗::Vector{Vector{Float64}}
    w⃗::Vector{Float64}
    εf::Matrix{Float64}
    εc::Matrix{Float64}
    integrator::SciMLBase.AbstractODEAlgorithm
    prob::SciMLBase.AbstractODEProblem

    function ε̇y(dε, ε, p, t)
        (; μ, δ, η, λ) = p
        λt = λ(t)
        # i = size of parameters, j = size of quadrature
        @tullio βy[i] := μ[i] * (log(λt) - ε[i])
        @tullio dε[i] = (abs(βy[i])^(δ[i] - 1)) * βy[i] / η[i]
        # return dε
    end

    function Miehe2005(; s=5, n=21, hyperelastic=NonaffineMicroSphere(), integrator=Tsit5(), ε₀f=zeros(s,n), ε₀c=zeros(s,n), t₀=0.0)
        if n == 21
            a = √(2) / 2
            b = 0.836095596749
            c = 0.387907304067
            r⃗ = [
                [0, 0, 1],
                [0, 1, 0],
                [1, 0, 0],
                [0, a, a],
                [0, -a, a],
                [a, 0, a],
                [-a, 0, a],
                [a, a, 0],
                [-a, a, 0],
                [b, c, c],
                [-b, c, c],
                [b, -c, c],
                [-b, -c, c],
                [c, b, c],
                [-c, b, c],
                [c, -b, c],
                [-c, -b, c],
                [c, c, b],
                [-c, c, b],
                [c, -c, b],
                [-c, -c, b],
            ]
            w1 = 0.02652142440932
            w2 = 0.0199301476312
            w3 = 0.0250712367487

            w = 2 .* [fill(w1, 3); fill(w2, 6); fill(w3, 12)] # Multiply by two since integration is over the half-sphere
        else
            @error "Method not implemented for n = $(n)"
        end
        ε₀ = zeros(s,n)
        tspan = (0.0, 1.0)
        ps = NamedTuple()
        prob = ODEProblem(ε̇y, ε₀, tspan, ps)
        new(hyperelastic, r⃗, w, ε₀f, ε₀c, integrator, prob)
    end
end

function evolve_internal_state(ψ::Miehe2005, history::MaterialHistory, ps)
    λ⃗₀ = history.value[end-1]
    λ⃗₁ = history.value[end]
    t₀ = history.time[end-1]
    t₁ = history.time[end]

    @tullio λf₀[j] := sqrt(sum(λ⃗₀ .^ 2 .* ψ.r⃗[j] .^ 2))
    @tullio λf₁[j] := sqrt(sum(λ⃗₁ .^ 2 .* ψ.r⃗[j] .^ 2))
    @tullio λc₀[j] := sqrt(sum(λ⃗₀ .^ -2 .* ψ.r⃗[j] .^ 2))
    @tullio λc₁[j] := sqrt(sum(λ⃗₁ .^ -2 .* ψ.r⃗[j] .^ 2))

    λf(t) = @. λf₀ + (λf₁ - λf₀) / (t₁ - t₀) * t
    λc(t) = @. λc₀ + (λc₁ - λc₀) / (t₁ - t₀) * t

    εf_prob = remake(
        ψ.prob,
        u0=ψ.εf,
        tspan=(t₀, t₁),
        p=(
            μ=ps.μ.f⃗,
            η=ps.η.f⃗,
            δ=ps.δ.f⃗,
            λ=λf
        )
    )

    εc_prob = remake(
        ψ.prob,
        u0=ψ.εc,
        tspan=(t₀, t₁),
        p=(
            μ=ps.μ.c⃗,
            η=ps.η.c⃗,
            δ=ps.δ.c⃗,
            λ=λc
        )
    )

    εf = solve(εf_prob, ψ.integrator).u[end]
    εc = solve(εc_prob, ψ.integrator).u[end]
    return εf, εc
end

function update_internal_state!(ψ::Miehe2005, εf, εc)
    @. ψ.εf = εf
    @. ψ.εc = εc
end

function _StrainEnergyDensity(ψ::Miehe2005, history::MaterialHistory, ps)
    λ⃗₁ = history.value[end]
    ψH = StrainEnergyDensity(ψ.hyperelastic, λ⃗₁, ps.hyperelastic)

    εf₁, εc₁ = evolve_internal_state(ψ, history, ps)

    @tullio λf₁ := sqrt(sum(λ⃗₁ .^ 2 .* ψ.r⃗[i] .^ 2)) * ψ.w⃗[i]
    @tullio λc₁ := sqrt(sum(λ⃗₁ .^ -2 .* ψ.r⃗[i] .^ 2)) * ψ.w⃗[i]

    ψv_f = @. ps.μ.f⃗ * (log(λf₁ - εf₁))^2
    ψv_c = @. ps.μ.c⃗ * (log(λc₁ - εc₁))^2
    ψv = 1 / 2 * (sum(ψv_f) + sum(ψv_c))
    W = ψH + ψv
    return W, εf₁, εc₁
end

function NonlinearContinua.StrainEnergyDensity(ψ::Miehe2005, history::MaterialHistory, ps)
    W = _StrainEnergyDensity(ψ, history, ps)[1]
    return W
end

function NonlinearContinua.StrainEnergyDensity!(ψ::Miehe2005, history::MaterialHistory, ps)
    W, εf₁, εc₁ = _StrainEnergyDensity(ψ, history, ps)
    update_internal_state!(ψ, εf₁, εc₁)
    return W
end

function NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Miehe2005, history::MaterialHistory, ps)
    λ⃗ = history.value[end]
    sH = SecondPiolaKirchoffStressTensor(ψ.hyperelastic, λ⃗, ps.hyperelastic)
    εf, εc = evolve_internal_state(ψ, history, ps)
    update_internal_state!(ψ, εf, εc)

    @tullio λf[j] := sqrt(sum(λ⃗ .^ 2 .* ψ.r⃗[j] .^ 2))
    @tullio λc[j] := sqrt(sum(λ⃗ .^ -2 .* ψ.r⃗[j] .^ 2))

    @tullio λ̄f := λf[j] * ψ.w⃗[j]
    @tullio λ̄c := λc[j] * ψ.w⃗[j]

    @tullio βf := ps.μ.f⃗[i] * (log(λf[j]) - εf[i, j])/λ̄f
    @tullio βc := ps.μ.f⃗[i] * (log(λc[j]) - εc[i, j])/λ̄c

    function f(λ)

        @tullio λf[j] := sqrt(sum(λ .^ 2  .* ψ.r⃗[j] .^ 2))
        @tullio λc[j] := sqrt(sum(λ .^ -2 .* ψ.r⃗[j] .^ 2))

        @tullio ψv_f := ps.μ.f⃗[i] * (log(λf[j] - εf[i,j]))^2*ψ.w⃗[j]
        @tullio ψv_c := ps.μ.c⃗[i] * (log(λc[j] - εc[i,j]))^2*ψ.w⃗[j]

        return ψv_c+ψv_f

    end
    sV = AD.gradient(AD.ForwardDiffBackend(), f, history.value[end])[1]
    return sH+sV
end
function NonlinearContinua.CauchyStressTensor(ψ::Miehe2005, history::MaterialHistory, ps)

end
