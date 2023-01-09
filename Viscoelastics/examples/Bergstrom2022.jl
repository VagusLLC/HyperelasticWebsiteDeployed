using DifferentialEquations, Tullio, NonlinearSolve, SciMLNLSolve
using Hyperelastics, Viscoelastics, InverseLangevinApproximations
using LinearAlgebra
##
ramp(x) = (x + abs(x)) / 2.0

##
ℒinv(x) = x * (3 - x^2) / (1 - x^2)
ℒinv(x) = 3x + 9 / 5 * x^3 + 297 / 175 * x^5 + 1539 / 875 * x^7
ℒinv(x) = (abs(x) < 0.84136) ? (1.31446 * tan(1.58986 * x) + 0.91209 * x) : (1 / (sign(x) − x))
##
function CompressibleArrudaBoyce(λ, p)
    (; μ, λL, κ) = p
    J = prod(λ)
    bstar = λ .* J^(-2 / 3)
    λch = sqrt(sum(bstar) / 3)
    dev_bstar = bstar .- sum(bstar) / 3
    @tullio σ[i] := μ / (J * λch) * ℒinv(λch / λL) / ℒinv(1 / λL) * dev_bstar[i] + κ * (J - 1)
    return σ
end
##
function f!(λ̇B_p, λB_p, p, t)
    (; λB0, λB1, Δt, σ, B, Ĉ₁, C₂, m, τBase, τCut) = p
    λB = λB0 + (λB1 - λB0) * t / Δt
    λB_e = λB ./ λB_p
    σB = σ(λB_e, B)
    σB_dev = σB .- sum(σB) / 3
    τB = norm(σB_dev)
    λB_p_ch = sqrt(sum(λB_p .^ 2) / 3)
    γ̇ = (τB > 0.0) ? (Ĉ₁ * (λB_p_ch - 1)^(C₂) * ((ramp(τB / τBase - τCut))^(m - 1))) : (0.0)
    λB_e_inv = inv.(λB_e)
    λ̇B_p .= λB_e_inv .* γ̇ .* σB_dev .* λB_p
end
##
function BerstromBoyceStep(λ_start, λ_stop, λv, Δt, ps)
    (; A, B, σ) = ps
    σA = σ(λ_stop, A)
    λv .= solve(
        ODEProblem(
            f!,
            λv,
            (0.0, Δt),
            (
                λB0=λ_start,
                λB1=λ_stop,
                Δt=Δt,
                σ=ps.σ,
                B=ps.B,
                Ĉ₁=ps.Ĉ₁,
                C₂=ps.C₂,
                m=ps.m,
                τBase=ps.τBase,
                τCut=ps.τCut
            )
        ),
        Rodas4(),
        reltol=1e-8,
        abstol=1e-8
    ).u[end]
    λe_stop = λ_stop ./ λv
    σB = σ(λe_stop, B)
    σ = σA + σB
    return σ
end
##
function uniaxialTest(time_vec, stretch_vec, params)
    stress = similar(stretch_vec)
    λ₂ = similar(stretch_vec)
    stress[1] = 0.0
    λ₂[1] = 1.0
    λ₂_stop = λ₂_start = 1.0
    λv = ones(3)*1.05
    for i in range(1, length(time_vec) - 1)
        t_start = time_vec[i]
        t_stop = time_vec[i+1]
        λ₁_start = stretch_vec[i]
        λ₁_stop = stretch_vec[i+1]
        λ_start = [λ₁_start, λ₂_start, λ₂_start]
        σ2_abs(λ₂, _) = BerstromBoyceStep(λ_start, [λ₁_stop, λ₂[1], λ₂[1]], copy(λv), t_stop - t_start, params)[3]
        nl_prob = NonlinearProblem(σ2_abs, [λ₂_start], [])
        λ₂_stop = solve(nl_prob, NLSolveJL(), abstol=1e-9, reltol=1e-9).u[1]
        λ_stop = [λ₁_stop, λ₂_stop, λ₂_stop]
        σ = BerstromBoyceStep(λ_start, λ_stop, λv, t_stop - t_start, params)
        stress[i+1] = σ[1]
        λ₂[i+1] = λ₂_stop
    end
    return stress, λ₂
end
##
N = 100
t_vec = range(0.0, 0.8/0.01*2, 2N);
p = (
    A=(μ=0.2, λL=sqrt(8), κ=100.0),
    B=(μ=0.2 * 1.6, λL=sqrt(8), κ=100.0),
    σ=CompressibleArrudaBoyce,
    Ĉ₁ = 7.0,
    C₂ = -1.0,
    m=4.0,
    Δt=t_vec.step.hi,
    τBase=0.5,
    τCut=0.08,
)
λ_vec = vcat(exp.(range(0.0, -0.8, N)),exp.(range(-0.8, 0.0, N)))
σ, λ₂ = uniaxialTest(t_vec, λ_vec, p)
J = λ_vec .* (λ₂ .^ 2)
plot(-log.(λ_vec), -σ)#, axis=(; yticks=0.0:0.2:2.2))
