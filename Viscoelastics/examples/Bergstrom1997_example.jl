using Viscoelastics, Hyperelastics
using CairoMakie
using NonlinearSolve, SciMLNLSolve
using LinearAlgebra, ComponentArrays
## ---- Figure 8.10 from Mechanics of Solid Polymers ----
N = 5000
t = range(0, 16π, length=N)[2:end]
function disp(t)
    λmax = 4.0
    λmin = 1.0
    λ̇ = 1.0
    t_half = (λmax-λmin)/λ̇
    iseven(div(t, t_half)) ? λmin + λ̇*mod(t, t_half) : (λmax) - λ̇*mod(t, t_half)
end
# λ = exp.((sin.(2.0*t).*1.5))[2:end]
λ = disp.(t)
lines(t, λ)
## - - - - - -
function uniaxial_stress_visco(ψ, time_vec, stretch_vec, ps)
    stress = Vector{Float64}[]
    λ2_2 = 1.0
    for (t, λ1) in zip(time_vec, stretch_vec)
        @show t, λ1
        function find_λ₂(λ2, p)
            σ = CauchyStressTensor(ψ, (t = t, F = [λ1, λ2[1], λ2[1]]), p)
            return [abs(σ[3])]
        end
        u0 = [λ2_2]
        prob = NonlinearProblem(find_λ₂, u0, ps)
        sol = solve(prob, NewtonRaphson())
        λ2_2 = sol.u[1]
        res = CauchyStressTensor!(ψ, (t = t, F = [λ1, λ2_2, λ2_2]), ps)
        push!(stress, res)
    end
    return stress
end
##
ψ = Bergstrom1997()
ps = ComponentVector(
    A=(
        hyperelastic=(
            ψ=(
                μ=2.0,
                N=3.5^2
            ),
            κ=100.0
        ),
    ),
    B = (
        hyperelastic=(
            ψ=(
                μ=2.0 * 3.0,
                N=3.5^2
            ),
            κ=100.0
        ),
        flow=(
            ξ=0.05,
            C=2.0,
            τBase=1.0,
            τCut=0.5,
            m=2.0
        )
    )
)
σ̂ = uniaxial_stress_visco(ψ, t, λ, ps)
lines(λ, getindex.(σ̂, 1), label="Bergstrom")
current_figure()
