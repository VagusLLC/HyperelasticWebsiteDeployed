### A Pluto.jl notebook ###
# v0.19.14

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
		Pkg.PackageSpec(name="CairoMakie"),
		Pkg.PackageSpec(name="MakiePublication"),
		Pkg.PackageSpec(name="Bibliography"),
		Pkg.PackageSpec(name="ForwardDiff"),
		Pkg.PackageSpec(name="CSV"),
		Pkg.PackageSpec(name="ComponentArrays"),
		Pkg.PackageSpec(name="Symbolics"),
		Pkg.PackageSpec(name="DataFrames"),
		Pkg.PackageSpec(name="Optimization"), 
		Pkg.PackageSpec(name="OptimizationOptimJL"),
		Pkg.PackageSpec(name="Unitful"),
		Pkg.PackageSpec(name="LabelledArrays"),
		Pkg.PackageSpec(name="HypertextLiteral"),
	])
	Pkg.develop([
		Pkg.PackageSpec(path=joinpath(local_dir, "InverseLangevinApproximations")),
		Pkg.PackageSpec(path=joinpath(local_dir, "Hyperelastics")),
		Pkg.PackageSpec(path=joinpath(local_dir, "ContinuumModels")),
		Pkg.PackageSpec(path=joinpath(local_dir, "PlutoUI")),
	])
	using PlotlyLight, PlutoUI, Bibliography, ForwardDiff, CSV, Symbolics, ComponentArrays, DataFrames, Optimization, OptimizationOptimJL, Unitful, Hyperelastics, InverseLangevinApproximations, ContinuumModels, LabelledArrays, CairoMakie, MakiePublication
end

# ╔═╡ 0dd8b7de-570d-41a7-b83d-d1bbe39c017e
TableOfContents()

# ╔═╡ 73ab5774-dc3c-4759-92c4-7f7917c18cbf
HTML("""<center><h1>Vagus, LLC - Hyperelastic Model Fitting Toolbox</h1></center>
		<center><h2>Upload Uniaxial Test Data</h2></center>
		""")

# ╔═╡ 6434a755-90be-45f8-8e1e-cdeba4be244b
@bind data FilePicker()

# ╔═╡ f12538a9-f595-4fae-b76c-078179bc5109
HTML("""<center><h2>Verification Plot</h2></center>""")

# ╔═╡ d0319d95-f335-48fa-b789-59daf9a0f1a4
HTML("""<center><h2>Select Hyperelastic Model</h2></center>""")

# ╔═╡ 9343a51e-5002-4489-a55f-12c49f5b8cf3
md"""
!!! note "Note"
	- When selecting a phenomenological model, be aware that using higher order models may result in overfitting of the data.
	- All moduli in models are in the defined stress units above
"""

# ╔═╡ c6e726ab-ea78-4129-a662-338976633cd5
html"""<center><h2> Set initial parameter guess</h2></center>"""

# ╔═╡ f2a51df9-0396-436d-926c-587ad6e41ff4
# ╠═╡ show_logs = false
# begin
# 	str = let
# 	_str = "<span>"
# 	columns = string.(parameters(getfield(Hyperelastics, model)()))
# 	output_string = "{"
# 	for column ∈ columns
# 		output_string *= """$(column):$(column)_$(1).value,"""
# 	end
# 	output_string *= "make_model: make_model.checked"
# 	output_string *= """}"""
# ####################             HTML        ##############################
# 	_str *= """<center><h3> Initial Parameter Guess</h3></center>"""
# 	_str *= """<table>"""
# 	for column ∈ columns
# 		_str *=	"""<th>$(replace(column, "_" => " "))</th>"""
# 	end
# 	_str *= """<tr>"""
# 	for column ∈ columns
# 		_str *= """<td><input type = "text" id = "$(column)_$(1)"></input></td>"""
# 	end
# 	_str *= """</tr>"""
# 	_str *= """<tfoot><tr><td></td>"""
# 	_str *= """<td></td></tr></tfoot>"""
# 	_str *= """</table>"""
# 	_str *= """<center>Fit Parameters:<input type = "checkbox" id = "make_model"</input></center>"""
# ######################        JAVASCRIPT            ####################
# 	_str *= """
# 		<script>		
# 			var span = currentScript.parentElement
# 		"""
# 		for column ∈ columns
# 		_str*="""
# 			var $(column)_$(1) = document.getElementById("$(column)_$(1)")
		
# 			$(column)_$(1).addEventListener("input", (e) => {
# 				span.value = $(output_string)
# 				span.dispatchEvent(new CustomEvent("input"))
# 				e.preventDefault()
# 			})
# 		"""
# 		end
		
# 	for i ∈ ["make_model"]
# 		_str*="""
# 			var $(i) = document.getElementById("$(i)")
# 			$(i).addEventListener("input", (e) => {
# 				span.value = $(output_string)
# 				span.dispatchEvent(new CustomEvent("input"))
# 				e.preventDefault()
# 			})
# 		"""
# 	end
# 	_str*="""
# 		span.value = $(output_string)
# 		</script>
# 		</span>
# 		"""
# 	end
# 	@bind ps HTML(str)
# end

# ╔═╡ e0e7407d-fe60-4583-8060-3ba38c22c409
begin
hyperelastic_models = filter(x -> typeof(getfield(Hyperelastics, x)) <: DataType,names(Hyperelastics))
hyperelastic_models = filter(x -> !(getfield(Hyperelastics, x) <: Hyperelastics.AbstractDataDrivenHyperelasticModel) && (getfield(Hyperelastics, x) <: Hyperelastics.AbstractHyperelasticModel), hyperelastic_models)
end;

# ╔═╡ 2f1fde4b-6bd8-42b4-bf5c-d61006d55f10
@bind model Select(hyperelastic_models)

# ╔═╡ 86f7e74f-c0a9-4561-85b9-f3ed6559facc
function ShearModulus(ψ, ps)
	s(x) = ForwardDiff.gradient(x->StrainEnergyDensity(ψ, x, ps), x)[1]-ForwardDiff.gradient(x->StrainEnergyDensity(ψ, x, ps), x)[3]*x[3]
	ForwardDiff.gradient(y->s(y)[1], [1.0, 1.0, 1.0])[1]
end;

# ╔═╡ 8ea07dab-06dc-456d-9769-5e9c3980a777
ElasticModulus(ψ, ps) = ShearModulus(ψ, ps)*3;

# ╔═╡ 7998136a-de3d-42f9-9028-1172415c8b75
if !isnothing(data)
	df = CSV.read(data["data"], DataFrame);
end;

# ╔═╡ 69068002-ca3a-4e19-9562-6736d3b15dea
if !isnothing(data)
md"""
Stress Column: $(@bind stress_column Select(names(df)))

Stretch Column: $(@bind stretch_column Select(names(df)))

Stress Units: $(@bind stress_units TextField())
"""
end

# ╔═╡ 2607b1b6-9c9c-482f-b38b-35e83a57f5d3
if !isnothing(data)
	scatter(
		df[!, stretch_column], 
		df[!, stress_column],
		name="Experimental",
		axis = (xlabel = "Stretch", ylabel = "Stress [$stress_units]")
	)
end

# ╔═╡ 12256359-1dca-4a71-a225-66994e2dfd66
if !isnothing(data)
	he_data = UniaxialHyperelasticData(df[!, stress_column], df[!, stretch_column]);
end;

# ╔═╡ d495c5e5-bf33-475c-a49a-5c9f8dc13789
set_theme!(MakiePublication.theme_web(width = 1000))

# ╔═╡ b911d517-cf5d-4c9c-b838-eaa41b74329e
begin
	Hyperelastics.parameters(ψ::ContinuumHybrid) = (:K1, :K2, :α, :μ)
	Hyperelastics.parameters(ψ::Zhao) = (:Cm11, :C11, :C21, :C22)
	Hyperelastics.parameters(ψ::Zhao) = (:Cm11, :C11, :C21, :C22)
	Hyperelastics.parameters(ψ::HartSmith) = (:G, :k1, :k2)
	Hyperelastics.parameters(ψ::GornetDesmorat) = (:h1, :h2, :h3)
	Hyperelastics.parameters(ψ::Alexander) = (:C1, :C2, :C3, :k, :γ)
	Hyperelastics.parameters(ψ::Beatty) = (:G0, :Im)
	Hyperelastics.parameters(ψ::ZunigaBeatty) = (:μ, :N3, :N8)
	Hyperelastics.parameters(ψ::Lim) = (:μ1, :μ2, :N, :Î1)
	Hyperelastics.parameters(ψ::BechirChevalier) = (:μ0, :η, :ρ, :N3, :N8)
end

# ╔═╡ 4d6f03c0-203a-4536-8ca2-c3dd77182ce6
function set_parameters(model)
	ps = Hyperelastics.parameters(getfield(Hyperelastics, model)())
	return PlutoUI.combine() do Child
		inputs = [
			md"""$(string(p)) $(Child(string(p), TextField()))"""
			for p in ps
		]
		md"""
		$(inputs)
		Fit Model: $(@bind fit_model CheckBox())
		"""
	end
end;

# ╔═╡ 703091d0-bf33-4baf-b75e-43e01b42ec0b
@bind ps set_parameters(model)

# ╔═╡ d58bc6f1-a819-4d8b-8817-a742e93e8a7f
# begin
# 	parsed = false
# 	p₀ = LVector()
# 	if !isnothing(data) && !isnothing(ps)
# 		if ps["make_model"]
# 			ψ = getfield(Hyperelastics, Symbol(model))()
# 			fields = string.(parameters(ψ))
# 			vals = getindex.((ps,), fields)
# 		end
#   	parsed, p₀ = try
# 		true, LVector(NamedTuple(Symbol.(fields) .=> parse.(Float64, vals)))
# 	catch
# 		false, nothing
# 	end
# 	if parsed
# 		heprob = HyperelasticProblem(he_data, ψ, p₀, [])
# 		solution = solve(heprob, LBFGS())
# 		sol = NamedTuple(solution.u)
# 		sol
# 	end
# 	end
# 	nothing
# end

# ╔═╡ 1018d35f-42e9-4970-8a5f-f5cc6e951cbc
begin
	if !isnothing(data)
		parsed, p₀ = try
				true, LVector(NamedTuple(keys(ps) .=> parse.(Float64, values(ps))))
			catch
				false, nothing
		end
		if parsed && fit_model
			ψ = getfield(Hyperelastics, Symbol(model))()
			heprob = HyperelasticProblem(he_data, ψ, p₀, [])
			solution = solve(heprob, LBFGS())
			sol = NamedTuple(solution.u)
			sol
		end
	end
end;

# ╔═╡ 0fa152b1-462a-4f34-9753-13ef6ef63071
begin
	if !isnothing(data) && !isnothing(ps) && parsed && fit_model
		str_table = let
			_str = "<span>"
			columns = string.(parameters(getfield(Hyperelastics, model)()))
			####################             HTML        ##########################
			_str *= """<center><h3> Final Parameters</h3></center>"""
			_str *= """<table>"""
			for column ∈ columns
				_str *=	"""<th>$(replace(column, "_" => " "))</th>"""
			end
			_str *= """<tr>"""
			for column ∈ columns
				_str *= """<td>$(round(getfield(sol, Symbol(column)), sigdigits = 6))</input></td>"""
			end
			_str *= """</tr>"""
			_str *= """<tfoot><tr><td></td>"""
			_str *= """<td></td></tr></tfoot>"""
			_str *= """</table>"""
			_str *= """</span>"""
			end
		HTML(str_table)
		end
end

# ╔═╡ 1345476c-ee08-4233-8506-0ebc94a2bec5
let
	if !isnothing(data) 
	if parsed && fit_model
	ψ = getfield(Hyperelastics, Symbol(model))()
	s⃗ = map(λ -> SecondPiolaKirchoffStressTensor(ψ, λ, sol), collect.(he_data.λ⃗))
	s₁ = getindex.(s⃗, 1)
	s₃ = getindex.(s⃗, 3)
	λ₁ = getindex.(he_data.λ⃗, 1)
	λ₃ = getindex.(he_data.λ⃗, 3)
	Δs₁₃ = s₁.-s₃.*λ₃./λ₁
	# p_fit = Plot(
	# 	[
	# 		Config(
	# 			x = getindex.(he_data.λ⃗, 1), 
	# 			y = getindex.(he_data.s⃗, 1),
	# 			mode="markers",
	# 			type = "scatter",
	# 			name="Experimental"
	# 		),
	# 		Config(
	# 			x = getindex.(he_data.λ⃗, 1), 
	# 			y = Δs₁₃, 
	# 			name = split(split(string(ψ), ".")[2], "(")[1]
	# 		)
	# 	]
	# )
	# p_fit.layout.xaxis.title = "Stretch"
	# p_fit.layout.yaxis.title = "Stress [$stress_units]"
	# p_fit
	f = Figure()
	ax = CairoMakie.Axis(f,xlabel = "Stretch", ylabel = "Stress [$stress_units]")
	s1 = scatter!(
		ax,
		getindex.(he_data.λ⃗, 1), 
		getindex.(he_data.s⃗, 1),
		label = "Experimental"
	)
	l1 = lines!(
		ax,
		getindex.(he_data.λ⃗, 1), 
		Δs₁₃, 
		color = MakiePublication.seaborn_muted()[2],
		label = split(split(string(ψ), ".")[2], "(")[1]
	)
	axislegend(ax, [[l1], [s1]], [split(split(string(ψ), ".")[2], "(")[1]
 , "Experimental"], position = :lt, nbanks = 2)
	f[1,1] = ax
	f
	end
	end
end

# ╔═╡ 9441279c-49d9-4640-aca5-4576e6ee29ed
if !isnothing(data) && fit_model
if parsed && !isnothing(data)
	HTML("""
	<center><h2> Other Values </h2></center>
	Small Strain Shear Modulus: $(ShearModulus(ψ, sol)) $(stress_units)
	<br>
	Small Strain Elastic Modulus: $(ElasticModulus(ψ, sol)) $(stress_units)

	""")
end
end

# ╔═╡ fa546bd7-aaca-4dfb-ac03-72aa515c5343
# @bind ps confirm(set_parameters(model))

# ╔═╡ 4c674e97-7773-42e4-a4e9-513ddd8356be
# if !isnothing(data)
# 	p = Plot(
# 		Config(
# 			x = df[!, stretch_column], 
# 			y = df[!, stress_column],
# 			type = "scatter",
# 			mode="markers",
# 			name="Experimental"
# 		)
# 	)
# 	p.layout.xaxis.title = "Stretch"
# 	p.layout.yaxis.title = "Stress [$stress_units]"
# 	p
# end

# ╔═╡ Cell order:
# ╟─0dd8b7de-570d-41a7-b83d-d1bbe39c017e
# ╟─73ab5774-dc3c-4759-92c4-7f7917c18cbf
# ╟─6434a755-90be-45f8-8e1e-cdeba4be244b
# ╟─69068002-ca3a-4e19-9562-6736d3b15dea
# ╟─f12538a9-f595-4fae-b76c-078179bc5109
# ╟─2607b1b6-9c9c-482f-b38b-35e83a57f5d3
# ╟─d0319d95-f335-48fa-b789-59daf9a0f1a4
# ╟─9343a51e-5002-4489-a55f-12c49f5b8cf3
# ╟─2f1fde4b-6bd8-42b4-bf5c-d61006d55f10
# ╟─c6e726ab-ea78-4129-a662-338976633cd5
# ╟─703091d0-bf33-4baf-b75e-43e01b42ec0b
# ╟─f2a51df9-0396-436d-926c-587ad6e41ff4
# ╟─0fa152b1-462a-4f34-9753-13ef6ef63071
# ╟─1345476c-ee08-4233-8506-0ebc94a2bec5
# ╟─9441279c-49d9-4640-aca5-4576e6ee29ed
# ╟─e5a18d4c-14cd-11ed-36d5-69de0fd02830
# ╟─e0e7407d-fe60-4583-8060-3ba38c22c409
# ╟─4d6f03c0-203a-4536-8ca2-c3dd77182ce6
# ╟─86f7e74f-c0a9-4561-85b9-f3ed6559facc
# ╟─8ea07dab-06dc-456d-9769-5e9c3980a777
# ╟─12256359-1dca-4a71-a225-66994e2dfd66
# ╟─7998136a-de3d-42f9-9028-1172415c8b75
# ╟─d495c5e5-bf33-475c-a49a-5c9f8dc13789
# ╟─b911d517-cf5d-4c9c-b838-eaa41b74329e
# ╟─d58bc6f1-a819-4d8b-8817-a742e93e8a7f
# ╟─1018d35f-42e9-4970-8a5f-f5cc6e951cbc
# ╟─fa546bd7-aaca-4dfb-ac03-72aa515c5343
# ╟─4c674e97-7773-42e4-a4e9-513ddd8356be
