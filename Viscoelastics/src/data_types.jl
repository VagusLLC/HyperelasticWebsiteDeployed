struct UniaxialViscousData <: AbstractViscousData
    λ⃗::Vector
    λ⃗̇::Vector
    s⃗::Vector
    t::Vector
    function UniaxialViscousData(λ₁, λ̇₁::Real, t, s₁)
        λ⃗ = map(λ₁ -> [λ₁, 1 / √λ₁, 1 / √λ₁], λ₁)
        λ̇₂ = map(λ⃗ -> -λ⃗[2]*λ̇₁/λ⃗[1], λ⃗)
        λ⃗̇ = map(x -> [λ̇₁, x, x], λ̇₂)
        s⃗ = map(s₁ -> [s₁], s₁)
        new(λ⃗, λ⃗̇, t, s⃗)
    end
    function UniaxialViscousData(λ₁, λ̇₁::Vector, t, s₁)
        λ⃗ = map(λ₁ -> [λ₁, 1 / √λ₁, 1 / √λ₁], λ₁)
        λ₂ = λ₃ = getindex.(λ⃗, 2)
        λ̇₂ = @. (-λ₂*λ₃*λ̇₁-λ₁*λ₃*λ̇₂)/(λ₁*λ₂)
        λ⃗̇ = map(x -> [λ̇₁, x, x], λ̇₂)
        s⃗ = map(s₁ -> [s₁], s₁)
        new(λ⃗, λ⃗̇, t, s⃗)
    end
end

struct BiaxialViscousData <: AbstractViscousData
    λ⃗::Vector
    λ⃗̇::Vector
    s⃗::Vector
    t::Vector
    function BiaxialViscousData(λ₁, λ₂, λ̇₁::Real, λ̇₂::Real, t, s₁, s₂)
        λ⃗ = map(λ -> [λ[1], λ[2], 1 / λ[1] / λ[2]], zip(λ₁, λ₂))
        λ₃ = getindex.(λ⃗, 3)
        λ̇₃ = @. (-λ₂*λ₃*λ̇₁-λ₁*λ₃*λ̇₂)/(λ₁*λ₂)
        λ⃗̇ = map(λ̇₃ -> [λ̇₁, λ̇₂, λ̇₃], λ̇₃)
        s⃗ = map(s -> [s[1], s[2]],zip(s₁, s₂))
        new(λ⃗, λ⃗̇, t, s⃗)
    end
    function BiaxialViscousData(λ₁, λ₂, λ̇₁::Vector, λ̇₂::Vector, t, s₁, s₂)
        λ⃗ = map(λ -> [λ[1], λ[2], 1 / λ[1] / λ[2]], zip(λ₁, λ₂))
        λ₃ = getindex.(λ⃗, 3)
        λ̇₃ = @. (-λ₂*λ₃*λ̇₁-λ₁*λ₃*λ̇₂)/(λ₁*λ₂)
        λ⃗̇ = map(x -> [x[1], x[2], x[3]], zip(λ̇₁, λ̇₂, λ̇₃))
        s⃗ = map(s -> [s[1], s[2]],zip(s₁, s₂))
        new(λ⃗, λ⃗̇, t, s⃗)
    end
end

function ViscoelasticProblem(ψ::AbstractViscousModel, data::AbstractViscousData, p₀)

end
