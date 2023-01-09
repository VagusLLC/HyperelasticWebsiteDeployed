export PowerFlow, BergstromBoyceFlow, NoFlow
export FlowRule


"""
PowerFlow

Model:
```math
\\dot{\\gamma}(\\lambda_v, \\sigma, p_{flow}) = \\left(\\frac{\\tau}{\\hat{\\tau} + a\\ R(-\\sigma_{hydro})} \\right)^m
```

where
```math
\\sigma_{hydro} = \\frac{\\sum\\limits_{i = 1}^{3}\\sigma_i}{3}
```
```math
\\tau = || \\sigma - \\sigma_{hydro} ||
```

Parameters:
- τ̂
- a
- m

>

"""
struct PowerFlow <: AbstractFlowModel end

function FlowRule(::PowerFlow, λv, σ, p)
    (; τ̂, a, m) = p
    σ_hydro = sum(σ) / 3
    σ_dev = σ .- σ_hydro
    τ = norm(σ_dev)
    γ̇ = (τ / (τ̂ + a * ramp(-σ_hydro)))^m
    return γ̇
end

"""
BergstromBoyceFlow

Model:

```math
\\dot{\\gamma}(\\lambda_v, \\sigma, p_{flow}) = \\left(\\lambda_{ch} - 1 + \\zeta \\right)^C \\left(R\\left(\\frac{\\tau}{\\tau_{Base} - \\tau_{Cut}}\\right)^m\\right)
```
where

```math
\\sigma_{hydro} = \\frac{\\sum\\limits_{i = 1}^{3}\\sigma_i}{3}
```

```math
\\tau = || \\sigma - \\sigma_{hydro} ||
```

```math
\\lambda_{ch} = \\sqrt{\\frac{I_1(\\lambda_v)}{3}}
```

Parameters:
- ξ
- C
- τBase
- τCut
- m

> Bergström JS, Boyce MC. Constitutive modeling of the time-dependent and cyclic loading of elastomers and application to soft biological tissues. Mechanics of materials. 2001 Sep 1;33(9):523-30.
> Bergström JS. Large strain time-dependent behavior of elastomeric materials (Doctoral dissertation, Massachusetts Institute of Technology).
"""
struct BergstromBoyceFlow <: AbstractFlowModel end

function FlowRule(::BergstromBoyceFlow, λv, σ, p)
    (; ξ, C, τBase, τCut, m) = p
    λchain = sqrt(I₁(λv) / 3)
    σ_dev = σ .- (sum(σ) / 3)
    τ = norm(σ_dev)
    _γ̇ = ((λchain - 1 + ξ)^C) * (ramp(τ / τBase - τCut)^m)
    return _γ̇
end


"""
NoFlow
"""
struct NoFlow <: AbstractFlowModel end
FlowRule(::NoFlow, λv, σ, p_flow) = 0
