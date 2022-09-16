### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ e5a18d4c-14cd-11ed-36d5-69de0fd02830
# ╠═╡ show_logs = false
begin
	local_dir = joinpath(splitpath(@__FILE__)[1:end-1])
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add([
		Pkg.PackageSpec(name="PlotlyLight"),
		Pkg.PackageSpec(name="PlutoUI"),
		Pkg.PackageSpec(name="Bibliography"),
		Pkg.PackageSpec(name="ForwardDiff"),
		Pkg.PackageSpec(name="CSV"),
		Pkg.PackageSpec(name="ComponentArrays"),
		Pkg.PackageSpec(name="Symbolics"),
		Pkg.PackageSpec(name="DataFrames"),
		Pkg.PackageSpec(name="Optimization"), 
		Pkg.PackageSpec(name="OptimizationOptimJL"),
		Pkg.PackageSpec(name="Unitful"),
	])
	Pkg.develop([
		Pkg.PackageSpec(path=joinpath(local_dir, "InverseLangevinApproximations")),
		Pkg.PackageSpec(path=joinpath(local_dir, "Hyperelastics")),
	])
	using PlotlyLight, PlutoUI, Bibliography, ForwardDiff, CSV, Symbolics, ComponentArrays, DataFrames, Optimization, OptimizationOptimJL, Unitful, Hyperelastics, InverseLangevinApproximations
	# d = Pkg.develop
	# d("InverseLangevinApproximations")
	# using InverseLangevinApproximations
	# d("Hyperelastics")
	# using Hyperelastics
end

# ╔═╡ 2a464508-4069-448b-a638-7253310ab16b
md"""
# Vagus, LLC - Hyperelastic Model Fitting Toolbox
"""

# ╔═╡ d354fac5-a772-480d-984f-dd5db4b39b5c
md"""
# Upload Dataset
"""

# ╔═╡ 6434a755-90be-45f8-8e1e-cdeba4be244b
@bind data FilePicker()

# ╔═╡ 4c674e97-7773-42e4-a4e9-513ddd8356be
if !isnothing(data)
	df = CSV.read(data["data"], DataFrame)
	he_data = UniaxialHyperelasticData(df.stress.*1e6, df.stretch)
	p = Plot(Config(x = df.stretch, y = df.stress))
	p.layout.xaxis.title = "Stretch"
	p.layout.yaxis.title = "Stress [MPa]"
	p
end

# ╔═╡ 7b095cb8-ab68-414f-966d-a964c5f2a256
md"""
# Select Hyperelastic Models to fit to the data
"""

# ╔═╡ 9343a51e-5002-4489-a55f-12c49f5b8cf3
md"""
When selecting a phenomenological model, be aware that using higher order models may result in overfitting of the data.
"""

# ╔═╡ e0e7407d-fe60-4583-8060-3ba38c22c409
begin
required = [
    :NominalStressFunction,
    :TrueStressFunction,
    :parameters,
    :StrainEnergyDensityFunction,
    :AbstractHyperelasticData,
    :BiaxialHyperelasticData,
    :UniaxialHyperelasticData,
    :HyperelasticProblem,
    :Hyperelastics,
    :I₁,
    :I₂,
    :I₃,
    :J,
    :Kawabata1981
]

data_driven = [
    :MacroMicroMacro,
    :SussmanBathe,
    :DataDrivenAverageChainBehavior,
    :SussmanBathe,
    :StabilitySmoothedSussmanBathe,
    :LatoreeMontans
]

hyperelastic_models = filter(x -> !(x in required) && !(x in data_driven), names(Hyperelastics))
end;

# ╔═╡ 2f1fde4b-6bd8-42b4-bf5c-d61006d55f10
@bind model Select(hyperelastic_models)

# ╔═╡ f42eeff0-941f-4091-8e09-57ed8cc1261e
begin
model
	md"""
## Fit the Model $(@bind fit CheckBox())
"""
end

# ╔═╡ 4d6f03c0-203a-4536-8ca2-c3dd77182ce6
function set_parameters(model)
	return PlutoUI.combine() do Child
		inputs = [
			md"""$(string(model)*" "*string(p)) $(Child(string(p), TextField()))"""
			for p in Hyperelastics.parameters(getfield(Hyperelastics, model)())
		]
		md"""
		#### Set initial parameter guess
		$(inputs)
		"""
	end
end;

# ╔═╡ fa546bd7-aaca-4dfb-ac03-72aa515c5343
@bind ps confirm(set_parameters(model))

# ╔═╡ 1018d35f-42e9-4970-8a5f-f5cc6e951cbc
# ╠═╡ show_logs = false
begin
	if fit
		ψ = getfield(Hyperelastics, Symbol(model))()
		ps_dict = Dict(pairs(ps))
		ps_conv = Dict{Symbol, Union{Float64, Vector{Float64}}}()
		for p in keys(ps_dict)
			if occursin("⃗", string(p))
				ps_conv[p] = parse.(Float64, split(ps[p], ","))
			else
				ps_conv[p] = parse.(Float64, ps[p])
			end
		end
		p₀ = ComponentVector(NamedTuple(ps_conv))
		# p₀ = ComponentVector(nums, ax)
		heprob = HyperelasticProblem(he_data, ψ, p₀, [])
		sol = solve(heprob, LBFGS())
		NamedTuple(sol.u)
	end
end

# ╔═╡ 1345476c-ee08-4233-8506-0ebc94a2bec5
begin
	if fit
	s⃗ = map(λ -> NominalStressFunction(ψ, λ, sol.u), collect.(he_data.λ⃗))
	s₁ = getindex.(s⃗, 1)
	s₃ = getindex.(s⃗, 3)
	λ₁ = getindex.(he_data.λ⃗, 1)
	λ₃ = getindex.(he_data.λ⃗, 3)
	Δs₁₃ = s₁.-s₃.*λ₃./λ₁
	p_fit = Plot(
		[
			Config(x = getindex.(he_data.λ⃗, 1), y = getindex.(he_data.s⃗, 1), name="Experimental"),
			Config(x = getindex.(he_data.λ⃗, 1), y = Δs₁₃, name = split(split(string(ψ), ".")[2], "(")[1])
		]
	)
	p_fit.layout.xaxis.title = "Stretch"
	p_fit.layout.yaxis.title = "Stress [Pa]"
	p_fit
	end
end

# ╔═╡ 86f7e74f-c0a9-4561-85b9-f3ed6559facc
function ShearModulus(ψ, ps)
	s(x) = ForwardDiff.gradient(x->StrainEnergyDensityFunction(ψ, x, ps), x)[1]-ForwardDiff.gradient(x->StrainEnergyDensityFunction(ψ, x, ps), x)[3]*x[3]/x[1]
	ForwardDiff.gradient(y->s(y)[1], [1.0, 1.0, 1.0])[1]
	# ForwardDiff.gradient(y->ForwardDiff.gradient(x->StrainEnergyDensityFunction(ψ, x, ps), y)[1], [1.0, 1.0, 1.0])[1]
end;

# ╔═╡ 8ea07dab-06dc-456d-9769-5e9c3980a777
ElasticModulus(ψ, ps) = ShearModulus(ψ, ps)*3;

# ╔═╡ 9441279c-49d9-4640-aca5-4576e6ee29ed
if fit
md"""
# Other Values

Small Strain Shear Modulus: $(ShearModulus(ψ, sol.u))

Small Strain Elastic Modulus: $(ElasticModulus(ψ, sol.u))

Optimizer Output:
$(display(sol.original))
"""
end

# ╔═╡ Cell order:
# ╟─2a464508-4069-448b-a638-7253310ab16b
# ╟─d354fac5-a772-480d-984f-dd5db4b39b5c
# ╟─6434a755-90be-45f8-8e1e-cdeba4be244b
# ╟─4c674e97-7773-42e4-a4e9-513ddd8356be
# ╟─7b095cb8-ab68-414f-966d-a964c5f2a256
# ╟─9343a51e-5002-4489-a55f-12c49f5b8cf3
# ╟─2f1fde4b-6bd8-42b4-bf5c-d61006d55f10
# ╟─fa546bd7-aaca-4dfb-ac03-72aa515c5343
# ╟─f42eeff0-941f-4091-8e09-57ed8cc1261e
# ╟─1018d35f-42e9-4970-8a5f-f5cc6e951cbc
# ╟─1345476c-ee08-4233-8506-0ebc94a2bec5
# ╟─9441279c-49d9-4640-aca5-4576e6ee29ed
# ╠═e5a18d4c-14cd-11ed-36d5-69de0fd02830
# ╟─e0e7407d-fe60-4583-8060-3ba38c22c409
# ╟─4d6f03c0-203a-4536-8ca2-c3dd77182ce6
# ╟─86f7e74f-c0a9-4561-85b9-f3ed6559facc
# ╟─8ea07dab-06dc-456d-9769-5e9c3980a777
