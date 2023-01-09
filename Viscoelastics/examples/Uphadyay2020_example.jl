using Viscoelastics, Hyperelastics
using Optimization, OptimizationOptimJL, ComponentArrays
using CairoMakie, MakiePublication
using LinearAlgebra
using CSV, DataFrames
set_theme!(theme_web(width=800))
##
f = Figure()
ax = Makie.Axis(f[1, 1], xticks=1.00:0.01:1.07)
##
df = CSV.read("examples/upadhyay2020_0.12.csv", DataFrame)
λ = [1.0; df.x]
s = [0.0; df.y]
λ̇ = 0.12
t = @. (λ - 1) / λ̇
uniaxial_test_012 = ViscousUniaxialTest(λ, s, t, name="λ̇ = 0.12")
df = CSV.read("examples/upadhyay2020_0.055.csv", DataFrame)
λ = [1.0; df.x]
s = [0.0; df.y]
λ̇ = 0.055
t = @. (λ - 1) / λ̇
uniaxial_test_0055 = ViscousUniaxialTest(λ, s, t, name="λ̇ = 0.055")
##
ψ = Upadhyay2020_3parameter()
ps = (
    hyperelastic=(
        C10=144.29,
        C01=-144.71
    ),
    viscous = (
        k11=-67.18,
        k21=74.05,!pip install rdkit-pypi
        c21=1.0
    )
)
ps = ComponentVector(ps)
##
result = predict(ψ, uniaxial_test_012, ps)
s̃₁ = getindex.(result.data.s, 1)
λ̃₁ = getindex.(result.data.λ, 1)
## T110
function T110_1p(λ, λ̇)
    C10 = 144.29
    C01 = -144.71
    k11 = 9.9
    _w1 = 2 * C10 * (λ - 1 / λ^2)
    _w2 = 2 * C01 * (1 - 1 / λ^3)
    _w3 = 4 * k11 * λ̇ * (2 * λ^2 + 1 / λ^4) * sqrt(λ^2 + 2 / λ - 3)
    return _w1 + _w2 + _w3
end
function T110_3p(λ, λ̇)
    C10 = 144.29
    C01 = -144.71
    k11 = -67.18
    k21 = 74.05
    c21 = 1.0
    _w1 = 2 * C10 * (λ - 1 / λ^2)
    _w2 = 2 * C01 * (1 - 1 / λ^3)
    _w3 = 4 * k11 * λ̇ * (2 * λ^2 + 1 / λ^4) * sqrt(λ^2 + 2 / λ - 3)
    _w4 = 2^(c21 + 1) * k21 * c21 * (λ̇^(2 * c21 - 1)) * ((2 * λ^4 + 1 / λ^5)^(c21)) * sqrt(2 * λ + 1 / λ^2 - 3)
    return _w1 + _w2 + _w3 + _w4
end
## Plot Initial Fits for 0.12
result = predict(ψ, uniaxial_test_012, ps)
λ₁ = getindex.(result.data.λ, 1)
s_jl = getindex.(result.data.s, 1)
s_3p = map(λ -> T110_3p(λ, 0.12), λ₁)
s_1p = map(λ -> T110_1p(λ, 0.12), λ₁)
lines!(ax, λ₁, s_3p, label="paper - 3p - 0.12")
lines!(ax, λ₁, s_1p, label="paper - 1p - 0.12")
# lines!(ax, λ₁, s_jl, label=".jl -0.12")
## Plot Initial Fits for 0.12
result = predict(ψ, uniaxial_test_0055, ps)
λ₁ = getindex.(result.data.λ, 1)
s_jl = getindex.(result.data.s, 1)
s_3p = map(λ -> T110_3p(λ, 0.055), λ₁)
s_1p = map(λ -> T110_1p(λ, 0.055), λ₁)
lines!(ax, λ₁, s_3p, label="paper - 3p - 0.055")
lines!(ax, λ₁, s_1p, label="paper - 1p - 0.055")
# lines!(ax, λ₁, s_jl, label=".jl - 0.55")
## Fit to data
tests = [uniaxial_test_012, uniaxial_test_0055]
prob = Viscoelastics.ViscousParameterCalibration(ψ, tests, ps, viscous_only = true)
sol = solve(prob, NelderMead())
ps.viscous = sol.u
## Plot - 0.12
result = predict(ψ, uniaxial_test_012, ps)
s = getindex.(result.data.s, 1)
λ = getindex.(result.data.λ, 1)
lines!(ax, λ, s, label="optim - 0.12")
## Plot - 0.055
result = predict(ψ, uniaxial_test_0055, ps)
s = getindex.(result.data.s, 1)
λ = getindex.(result.data.λ, 1)
lines!(λ, s, label="optim - 0.055")
## Scatter Plots
λ̂ = getindex.(uniaxial_test_012.data.λ, 1)
ŝ = getindex.(uniaxial_test_012.data.s, 1)
scatter!(ax, λ̂, ŝ, label="exp - 0.12s⁻¹", markersize=6)
λ̂ = getindex.(uniaxial_test_0055.data.λ, 1)
ŝ = getindex.(uniaxial_test_0055.data.s, 1)
scatter!(ax, λ̂, ŝ, label="exp - 0.055s⁻¹", markersize=6)
## Display Plot
axislegend(position=:rb)
current_figure()
