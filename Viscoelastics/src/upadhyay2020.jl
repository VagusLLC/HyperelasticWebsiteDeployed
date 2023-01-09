"""
Upadhyay 2020 [^1]

Note: History is tracked in terms of the deformation gradient tensor and time. This model assumes incompressability.

- Model Arguments
    - hyperelastic (Default = MooneyRivlin())

- Parameters
    - hyperelastic (Hyperelastic model parameters)
        - Default
            - C10
            - C01
    - viscous
        - c1
        - c2
        - k1
        - k2
[^1]: > Upadhyay K, Subhash G, Spearot D. Visco-hyperelastic constitutive modeling of strain rate sensitive soft materials. Journal of the Mechanics and Physics of Solids. 2020 Feb 1;135:103777.
"""
struct Upadhyay2020 <: AbstractViscousModel
    hyperelastic::Hyperelastics.AbstractHyperelasticModel
    interpolant::Function
end

struct Upadhyay2020_3parameter <: AbstractViscousModel
    hyperelastic::Hyperelastics.AbstractHyperelasticModel
    interpolant::Function
end

struct Upadhyay2020_1parameter <: AbstractViscousModel
    hyperelastic::Hyperelastics.AbstractHyperelasticModel
    interpolant::Function
end

function Upadhyay2020(; hyperelastic=MooneyRivlin(), interpolant=linear_interpolation)
    Upadhyay2020(hyperelastic, interpolant)
end
function Upadhyay2020_3parameter(; hyperelastic=MooneyRivlin(), interpolant=linear_interpolation)
    Upadhyay2020_3parameter(hyperelastic, interpolant)
end
function Upadhyay2020_1parameter(; hyperelastic=MooneyRivlin(), interpolant=linear_interpolation)
    Upadhyay2020_1parameter(hyperelastic, interpolant)
end

function Base.show(io::IO, ψ::Upadhyay2020)
    println("Viscoelastic Model: Upadhyay2020")
    println("\t Hyperelastic Model: ", ψ.hyperelastic)
    println("\t Interpolant: ", ψ.interpolant)
end

function NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Upadhyay2020, history::MaterialHistory{<:AbstractVector,<:Real}, p; adb=AD.ForwardDiffBackend())
    F = diagm(history.value[end])
    σ = CauchyStressTensor(ψ, history, p, adb=adb)
    S = det(F) * inv(F) * diagm(σ)
    return diag(S)
end

function NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Upadhyay2020, history::MaterialHistory{<:AbstractMatrix,<:Real}, p; adb=AD.ForwardDiffBackend())
    F = history.value[end]
    σ = CauchyStressTensor(ψ, history, p, adb=adb)
    S = det(F) * inv(F) * σ
    return S
end

function NonlinearContinua.CauchyStressTensor(ψ::Upadhyay2020, history::MaterialHistory{<:AbstractVector,<:Real}, p; adb=AD.ForwardDiffBackend())
    (; k1, k2, c1, c2) = p.viscous
    F₁ = F = diagm(history.value[end])
    F₂ = diagm(history.value[end-1])
    C₁ = F₁' * F₁
    C₂ = F₂' * F₂
    σₕ = CauchyStressTensor(ψ.hyperelastic, F, p.hyperelastic, adb=adb)
    ΔC = C₁ - C₂
    ΔF = F₁ - F₂
    Δt = history.time[end] - history.time[end-1]
    Ċ = ΔC / Δt
    Ḟ = ΔF / Δt
    L = Ḟ * inv(F)
    D = 1 / 2 * (L + L')
    B = F * F'
    C = F' * F
    J₂ = tr(Ċ^2)
    J₅ = tr(C * Ċ^2)

    @tullio ∂Wᵥ∂J₂ := k1[i] * c1[i] * J₂^(c1[i] - 1)
    @tullio ∂Wᵥ∂J₅ := k2[j] * c2[j] * J₅^(c2[j] - 1)

    (sum(isnan.(∂Wᵥ∂J₅))>0) ? (@show ∂Wᵥ∂J₅; @show p; @show J₅;@show Ċ) : ()
    hd = 8 * sqrt(I₁(F) - 3) * ∂Wᵥ∂J₂
    hd2 = 4 * sqrt(I₂(F) - 3) * ∂Wᵥ∂J₅
    σᵥ = hd * (B * D * B) + hd2 * (B * (B * D * B) + (B * D * B) * B)
    σ = σₕ + σᵥ
    return diag(σ)
end

function NonlinearContinua.CauchyStressTensor(ψ::Upadhyay2020, history::MaterialHistory{<:AbstractMatrix,<:Real}, p; adb=AD.ForwardDiffBackend())
    (; k1, k2, c1, c2) = p.viscous
    F₁ = F = history.value[end]
    F₂ = history.value[end-1]
    C₁ = F₁' * F₁
    C₂ = F₂' * F₂
    σₕ = CauchyStressTensor(ψ.hyperelastic, F, p.hyperelastic, adb=adb)
    ΔC = C₁ - C₂
    ΔF = F₁ - F₂
    Δt = history.time[end] - history.time[end-1]
    Ċ = ΔC / Δt
    Ḟ = ΔF / Δt
    L = Ḟ * inv(F)
    D = 1 / 2 * (L + L')
    B = F * F'
    C = F' * F
    J₂ = tr(Ċ^2)
    J₅ = tr(C * Ċ^2)
    @tullio ∂Wᵥ∂J₂ := k1[i] * c1[i] * J₂^(c1[i] - 1)
    @tullio ∂Wᵥ∂J₅ := k2[j] * c2[j] * J₅^(c2[j] - 1)
    hd = 8 * sqrt(I₁(F) - 3) * ∂Wᵥ∂J₂
    hd2 = 4 * sqrt(I₂(F) - 3) * ∂Wᵥ∂J₅
    σᵥ = hd * (B * D * B) + hd2 * (B * (B * D * B) + (B * D * B) * B)
    σ = σₕ + σᵥ
    return σ
end

NonlinearContinua.SecondPiolaKirchoffStressTensor!(ψ::Upadhyay2020, history::MaterialHistory, p; adb=AD.ForwardDiffBackend()) = NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Upadhyay2020, history::MaterialHistory, p; adb=abd)

NonlinearContinua.CauchyStressTensor!(ψ::Upadhyay2020, history::MaterialHistory, p; adb=AD.ForwardDiffBackend()) = NonlinearContinua.CauchyStressTensor(ψ::Upadhyay2020, history::MaterialHistory, p; adb=abd)


function NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Upadhyay2020_3parameter, history::MaterialHistory, p, adb=AD.ForwardDiffBackend())
    (; k11, k21, c21) = p.viscous
    ps = (
        hyperelastic=p.hyperelastic,
        viscous=(
            k1 = [k11],
            k2 = [k21],
            c1 = [1.0],
            c2 = [c21]
        )
    )
    return SecondPiolaKirchoffStressTensor(Upadhyay2020(hyperelastic=ψ.hyperelastic, interpolant=ψ.interpolant), history, ps, adb=adb)
end
function NonlinearContinua.SecondPiolaKirchoffStressTensor(ψ::Upadhyay2020_1parameter, history::MaterialHistory, p, adb=AD.ForwardDiffBackend())
    (; k11, ) = p.viscous
    ps = (
        hyperelastic=p.hyperelastic,
        viscous=(
            k1=[k11],
            k2=[1.0],
            c1=[1.0],
            c2=[1.0]
        )
    )
    return SecondPiolaKirchoffStressTensor(Upadhyay2020(hyperelastic=ψ.hyperelastic, interpolant=ψ.interpolant), history, ps, adb=adb)
end
function NonlinearContinua.CauchyStressTensor(ψ::Upadhyay2020_3parameter, history::MaterialHistory, p, adb=AD.ForwardDiffBackend())
    (; k11, k21, c21) = p.viscous
    ps = (
        hyperelastic=p.hyperelastic,
        viscous=(
            k1=[k11],
            k2=[k21],
            c1=[1.0],
            c2=[c21]
        )
    )
    return CauchyStressTensor(Upadhyay2020(hyperelastic=ψ.hyperelastic, interpolant=ψ.interpolant), history, ps, adb=adb)
end
function NonlinearContinua.CauchyStressTensor(ψ::Upadhyay2020_1parameter, history::MaterialHistory, p, adb=AD.ForwardDiffBackend())
    (; k11) = p.viscous
    ps = (
        hyperelastic=p.hyperelastic,
        viscous=(
            k1=[k11],
            k2=[1.0],
            c1=[1.0],
            c2=[1.0]
        )
    )
    return CauchyStressTensor(Upadhyay2020(hyperelastic=ψ.hyperelastic, interpolant=ψ.interpolant), history, ps, adb=adb)
end

function parameters(ψ::Upadhyay2020)
    (:k1, :k2, :c1, :c2)
end
function parameters(ψ::Upadhyay2020_3parameter)
    (:k11, :k21, :c21)
end
function parameters(ψ::Upadhyay2020_1parameter)
    (:k11, )
end
