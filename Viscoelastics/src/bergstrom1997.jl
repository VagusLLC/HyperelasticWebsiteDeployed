export Bergstrom1997
"""
`Bergstrom1997(;
    γ̇::Function=γ̇,
    initial_state=MaterialHistory([ones(3)], [0.0]),
    interpolant=linear_interpolation,
    A=LogarithmicCompressible(ArrudaBoyce()),
    B=LogarithmicCompressible(ArrudaBoyce())
    )
`
Model:

Fields:
- `γ̇(ψ, λ_v, σ_B, p)`: Stress evolution equations. Defaults to [^1]
- `initial_state`::MaterialHistory
- `interpolant`: linear_interpolant(x, f(x))
- `A`: Network A hyperelastic model (Defaults to LogarithmicCompressible(ArrudaBoyce))
- `B`: Network B hyperelastic model (Defaults to LogarithmicCompressible(ArrudaBoyce))

Parameters:
- A - Parameters for network A
    - Defaults:
        - μ
        - N
        - κ
- B - Parameters for network B
    - Defaults:
        - μ
        - N
        - κ
- γ̇ - Flow-rate equation parameters
    - Defaults:
        - C
        - ξ
        - τBase
        - τCut
        - m

[^1]: ```math
\\dot{\\gamma}_B = \\left(\\lambda_{chB}^v - 1 + \\zeta \\right)^C \\left(R\\left \\frac{\\tau}{\\tau_{Base}} - \\tau_{Cut} \\right) \\right)^m
```
"""
function Bergstrom1997(;
    initial_state = MaterialHistory(ones(3), 0.0),
    initial_ISV_state = Dict(:A=>MaterialHistory(ones(3), 0.0),:B=>MaterialHistory(ones(3), 0.0)),
    interpolant=linear_interpolation,
    A=LogarithmicCompressible(ArrudaBoyce()),
    B=LogarithmicCompressible(ArrudaBoyce())
)
    networks = Dict(
        :A => ParallelNetworkBranch(A),
        :B => ParallelNetworkBranch(B, flow = Viscoelastics.BergstromBoyceFlow())
    )

    prob = ODEProblem(
        Ḟv_GNM,
        ones(3),
        (0.0, 1.0),
        NamedTuple()
    )

    GeneralParallelNetworkModel(networks, [:A, :B], initial_state, initial_ISV_state, interpolant, prob)
end

# ramp(x) = (x >= zero(x)) * x

# function γ̇(ψ, λ_v, σ_B, p)
#     λchain = sqrt(I₁(λ_v) / 3)
#     σ_B_dev = σ_B .- (sum(σ_B) / 3)
#     τ = norm(σ_B_dev)
#     _γ̇ = ((λchain - 1 + p.ξ)^p.C) * (ramp(τ / p.τBase - p.τCut)^p.m)
#     return _γ̇
# end

# function Ḟv(dλ_v, λ_v, (; p, history, ψ, interpolant), t)
#     λ = interpolant(t)
#     λ_e = λ ./ λ_v
#     σ_B = CauchyStressTensor(ψ.B, λ_e, p.B)
#     σ_dev = σ_B .- (sum(σ_B) / 3)
#     τ = norm(σ_dev)
#     (τ > 0.0) ? (Nb = σ_dev / τ) : (Nb = zeros(size(λ_v)))
#     γ̇ = ψ.γ̇(ψ, λ_v, σ_B, p.γ̇)
#     if isnan(τ)
#         γ̇ = 0.0
#     end
#     @. dλ_v = γ̇ * inv(λ_e) * Nb * λ
#     return dλ_v
# end

# function _CauchyStressTensor(ψ::Bergstrom1997, history::MaterialHistory{<:AbstractVector,<:Real}, p)
#     σ_A = CauchyStressTensor(ψ.A, history.value[end], p.A)
#     λ_Bv = solve(
#                 ψ.prob,
#                 Tsit5(),
#                 reltol=1e-8,
#                 abstol=1e-8,
#                 save_everystep=false,
#                 u0=ψ.Fv_history.value[end],
#                 tspan=Tuple(history.time[end-1:end]),
#                 p=(
#                     p=p,
#                     ψ=ψ,
#                     history=history,
#                     interpolant=ψ.interpolant(history.time, history.value)
#                     ),
#             ).u[end]
#     λ_Be = history.value[end] ./ λ_Bv
#     σ_B = CauchyStressTensor(ψ.B, λ_Be, p.B)
#     σ = σ_A + σ_B
#     return (σ, λ_Bv)
# end

# function NonlinearContinua.CauchyStressTensor(ψ::Bergstrom1997, history::MaterialHistory{<:Vector,<:Real}, p)
#     res = _CauchyStressTensor(ψ, history, p)
#     return res[1]
# end

# function NonlinearContinua.CauchyStressTensor!(ψ::Bergstrom1997, history::MaterialHistory{<:Vector,<:Real}, p)
#     σ, λ_Bv = _CauchyStressTensor(ψ, his+tory, p)

#     @set ψ.Fv_history.value = push!(ψ.Fv_history.value, λ_Bv)
#     @set ψ.Fv_history.time  = push!(ψ.Fv_history.time, history.time[end])

#     return σ
# end

# function Base.show(io::IO, ψ::Bergstrom1997)
#     println(io, "Network A: ")
#     println(io, ψ.A)
#     println(io, "Network B: ")
#     println(io, ψ.B)
#     if ψ.γ̇ == γ̇
#         println(io, "Default Flow Rule")
#     else
#         println(io, "Custom Flow Rule")
#     end
# end
