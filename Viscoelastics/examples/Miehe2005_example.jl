using Viscoelastics
using CairoMakie
using Hyperelastics
using ForwardDiff
using FiniteDiff
##
p = (μ=0.139, N=5.18, p=1.166, U=11.2, q=0.126)
λ₁ = range(1.0, 4.0, length=101)
test = HyperelasticUniaxialTest(λ₁, name="hnbr50")
pred = Hyperelastics.predict(NonaffineMicroSphere(), test, p)
plt = lines(getindex.(pred.data.λ, 1), getindex.(pred.data.s, 1))
##
ψ = Miehe2005(s=3)
p_visco = (
    hyperelastic=p,
    μ=(
        f⃗=[6.16, 1.35, 1.76],
        c⃗=[7.19, 1.13, 1.63]
    ),
    δ=(
        f⃗=[2.97, 2.46, 24.46],
        c⃗=[1.02, 2.05, 16.47]
    ),
    η=(
        f⃗=[0.1, 10, 1000] .* [6.16, 1.35, 1.76],
        c⃗=[0.1, 10, 1000] .* [7.19, 1.13, 1.63]
    )
)

λ̇ = 5e-2
λ₁ = range(1.0, 2.0, length=101)
λ₂ = λ₃ = @. sqrt(1/λ₁)
t = @. (λ₁ - 1.0) / λ̇
test = ViscousUniaxialTest(λ₁, t, name = "hnbr50_5e-2")
history = MaterialHistory([ones(3)], [0.0])
W = Float64[]
s = Vector{Float64}[]
for i in 1:length(test.data)
    push!(history.value, test.data.λ[i])
    push!(history.time, test.data.t[i])
    push!(s, SecondPiolaKirchoffStressTensor(ψ, history, p_visco))

end
# s = sH .+ sV
Δs₁₃ = @. getindex(s, 1) - getindex(s, 3)*λ₃/λ₁
lines(collect(λ₁), Δs₁₃)
