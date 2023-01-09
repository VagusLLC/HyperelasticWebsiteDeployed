export Xiang2019
"""
Xiang-2019 model

Model:
```math
\\sigma(\\lambda(t)) = \\sigma^{H}+\\sigma^{H}_{v}-\\int\\limits_{-\\infty}^{t}\\sigma^{H}_{cf}(\\lambda(\\tau))\\frac{\\partial\\varphi(t-\\tau, \\tau_r)}{\\partial\\tau}+\\sigma^{H}_{ef}(\\lambda(\\tau))\\frac{\\partial\\varphi(t-\\tau, \\tau_d)}{\\partial\\tau}\\text{d}{\\tau}
```

where

```math
\\sigma^{H}_i = \\lambda_i\\frac{\\partial W}{\\partial \\lambda_i}
```

```math
W^{H} = G_C N \\log\\bigg(\\frac{3N+\\frac{1}{2}I_1}{3N-I_1}\\bigg)+G_e\\sum\\limits_{i=1}^{3}\\frac{1}{\\lambda_i}
```

```math
\\varphi(t, \\tau_r) = \\sum\\limits_{k=\\text{odd}}\\frac{8}{k^2\\pi^2}\\exp\\bigg(-\\frac{k^2 t}{\\tau}\\bigg)
```

Parameters:
- Hyperelastic
    - Gc
    - Ge
    - N
- Viscocous
    - Gc
    - Ge
    - N
- τr
- τd
---
> Xiang Y, Zhong D, Wang P, Yin T, Zhou H, Yu H, Baliga C, Qu S, Yang W. A physically based visco-hyperelastic constitutive model for soft materials. Journal of the Mechanics and Physics of Solids. 2019 Jul 1;128:208-18.
"""
struct Xiang2019
	prob::IntegralProblem
	ψH::NonlinearContinua.AbstractMaterialModel
	ψV_cf::NonlinearContinua.AbstractMaterialModel
	ψV_ef::NonlinearContinua.AbstractMaterialModel
    interpolant::Function
    history::MaterialHistory
	function Xiang2019(
            principal_coordinates = false;
			ψH = Hyperelastics.GeneralConstitutiveModel(),
			ψV_cf = Hyperelastics.GeneralConstitutiveModel_Network(),
			ψV_ef = Hyperelastics.GeneralConstitutiveModel_Tube(),
            interpolant = Interpolations.linear_interpolation,
            initial_state = MaterialHistory(ones(3), 0.0),
			N=20.0
			)
    	diter(k, t, τ, τc) = 8 / (τc * π^2) * exp(-(k^2) * (t - τ) / τc)
    	dφdτ(τ, t, τr) = sum(k -> diter(2 * k + 1, t, τ, τr), 0.0:N)
    	dψdτ(τ, t, τd) = sum(k -> diter(2 * k + 1, t, τ, τd), 0.0:N)

    	σV_cf(F, ps) = CauchyStressTensor(ψV_cf, F, ps)
    	σV_ef(F, ps) = CauchyStressTensor(ψV_ef, F, ps)
    	function conv!(τ, p)
        	(; F, t, ps) = p
        	t1 = vec(σV_cf(F(τ[1]), ps.ψV_cf) .* dφdτ(τ[1], t, ps.τr))
			t2 = vec(σV_ef(F(τ[1]), ps.ψV_cf) .* dψdτ(τ[1], t, ps.τd))
  	    	dτ = t1 + t2
     	   return dτ
	    end
    	p = (p = nothing)
        if principal_coordinates
        	prob = IntegralProblem(conv!, [0.0], [1.0], p=p, nout=3)
        else
            prob = IntegralProblem(conv!, [0.0], [1.0], p=p, nout=9)
        end
    	new(prob, ψH, ψV_cf, ψV_ef, interpolant, initial_state)
	end
end

# function NonlinearContinua.CauchyStressTensor(ψ::Xiang2019, history::MaterialHistory{<:AbstractMatrix,<:Real}, p)
#     σH = CauchyStressTensor(ψ.ψH, history.value[end], p.ψH)
#     σVH_ef = CauchyStressTensor(ψ.ψV_ef, history.value[end], p.ψV_ef)
#     σVH_cf = CauchyStressTensor(ψ.ψV_cf, history.value[end], p.ψV_cf)
#     prob = remake(
#         ψ.prob,
#         ub=[history.time[end]],
#         p=(
#             F=ψ.interpolant(history.time, history.value),
#             t=history.time[end],
#             ps=p
#         )
#     )
#     σVrelax = reshape(solve(prob, CubatureJLh()).u, 3, 3)
#     σ = σH + σVH_ef + σVH_cf - σVrelax
#     return σ
# end

function NonlinearContinua.CauchyStressTensor(ψ::Xiang2019, loading, p)
    σH = CauchyStressTensor(ψ.ψH, loading.F, p.ψH)
    σVH_ef = CauchyStressTensor(ψ.ψV_ef, loading.F, p.ψV_ef)
    σVH_cf = CauchyStressTensor(ψ.ψV_cf, loading.F, p.ψV_cf)
    prob = remake(
        ψ.prob,
        ub=[loading.t],
        p=(
            F=ψ.interpolant([ψ.history.time;loading.t], [ψ.history.value[:];[loading.F]]),
            t=loading.t,
            ps=p
        )
    )
    σVrelax = solve(prob, CubatureJLh()).u
    σ = σH + σVH_ef + σVH_cf - σVrelax
    return σ
end

function NonlinearContinua.CauchyStressTensor!(ψ::Xiang2019, loading, p)
    σ = CauchyStressTensor(ψ, loading, p)
    push!(ψ.history.value, loading.F)
    push!(ψ.history.time, loading.t)
    return σ
end

# function NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Xiang2019, history::MaterialHistory{<:AbstractMatrix, Float64}, ps)
#     σ = CauchyStressTensor(ψ, history, ps)
#     s = σ .* inv(transpose(history.value[end]))
#     return s
# end

function NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Xiang2019, loading, ps)
    σ = CauchyStressTensor(ψ, loading, ps)
    s = σ ./ loading.F
    return s
end

function NonlinearContinua.SecondPiolaKirchoffStressTensor!(ψ::Xiang2019, loading, ps)
    s = SecondPiolaKirchoffStressTensor(ψ, loading, ps)
    push!(ψ.history.value, loading.F)
    push!(ψ.history.time, loading.t)
    return s
end
