### A Pluto.jl notebook ###
# v0.19.19

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
		Pkg.PackageSpec(name="CairoMakie"),
		Pkg.PackageSpec(name="MakiePublication"),
		Pkg.PackageSpec(name="ForwardDiff"),
		Pkg.PackageSpec(name="AbstractDifferentiation"),
		Pkg.PackageSpec(name="CSV"),
		Pkg.PackageSpec(name="ComponentArrays"),
		Pkg.PackageSpec(name="DataFrames"),
		Pkg.PackageSpec(name="Optimization"), 
		Pkg.PackageSpec(name="OptimizationOptimJL"),
		Pkg.PackageSpec(name="LabelledArrays"),
		Pkg.PackageSpec(name="HypertextLiteral"),
		Pkg.PackageSpec(name="PlutoUI"),
	])
	Pkg.develop([
		Pkg.PackageSpec(path=joinpath(local_dir, "InverseLangevinApproximations")),
		Pkg.PackageSpec(path=joinpath(local_dir, "NonlinearContinua")),
		Pkg.PackageSpec(path=joinpath(local_dir, "Hyperelastics")),
		# Pkg.PackageSpec(path=joinpath(local_dir, "PlutoUI")),
	])
	using PlutoUI, AbstractDifferentiation, ForwardDiff, CSV, ComponentArrays, DataFrames, Optimization, OptimizationOptimJL, InverseLangevinApproximations, LabelledArrays, CairoMakie, MakiePublication
end

# ╔═╡ 2d189645-189f-4886-a6d5-5718a613798f
using Hyperelastics

# ╔═╡ 0dd8b7de-570d-41a7-b83d-d1bbe39c017e
TableOfContents()

# ╔═╡ 73ab5774-dc3c-4759-92c4-7f7917c18cbf
HTML("""<center><h1> Hyperelastic Model <br> Fitting Toolbox</h1></center>
		<center><h2>Upload Uniaxial Test Data</h2></center>
		""")

# ╔═╡ cac1e660-c03b-420a-b9bc-b4d4712ae325
# md"""
# Select data: $(@bind data_type Select([:Custom => "User Provided"], default = :Custom))
# """

# ╔═╡ 692b1d0d-2353-4931-b289-490f74988811
md"""
Test Type: $(@bind test_type Select([:Uniaxial, :Biaxial]))

Upload Data $(@bind data FilePicker())
"""

# ╔═╡ 7196aa51-e86d-4f0e-ae40-cc6aa74aa237
md"---"

# ╔═╡ 9e411ed3-0061-4831-b047-44c920959c83
HTML("""
<style>
	select, button, input {
   		font-size: 12px;
		font-family: "Archivo Black";
		}
	p, h2 {
		font-family: "Archivo Black";
	}
</style>""")

# ╔═╡ d495c5e5-bf33-475c-a49a-5c9f8dc13789
set_theme!(MakiePublication.theme_web(width = 1000))

# ╔═╡ 6f061996-be32-493d-80e2-daedec8bb103
exclude = [:HorganMurphy, :KhiemItskov, :GeneralCompressible, :LogarithmicCompressible, :GeneralMooneyRivlin];

# ╔═╡ e0e7407d-fe60-4583-8060-3ba38c22c409
begin
	ns = filter(x->x!=:citation, names(Hyperelastics))
	hyperelastic_models = filter(x -> typeof(getfield(Hyperelastics, x)) <: Union{DataType, UnionAll},ns)
	hyperelastic_models = filter(x -> !(getfield(Hyperelastics, x) <: Hyperelastics.AbstractDataDrivenHyperelasticModel) && (getfield(Hyperelastics, x) <: Hyperelastics.AbstractHyperelasticModel), hyperelastic_models)
	hyperelastic_models = filter(x -> !(x in exclude), hyperelastic_models)
	map(model->parameters(model()), Base.Fix1(getfield, Hyperelastics).( hyperelastic_models))
end;

# ╔═╡ 7998136a-de3d-42f9-9028-1172415c8b75
	if !isnothing(data)
		df = CSV.read(data["data"], DataFrame);
	end;

# ╔═╡ 69068002-ca3a-4e19-9562-6736d3b15dea
if !isnothing(data)
	if test_type == :Uniaxial
md"""
Stress Column: $(@bind stress_column Select(names(df)))

Stretch Column: $(@bind stretch_column Select(names(df)))

"""
		# Stress Units: $(@bind stress_units TextField())

# Test Name: $(@bind test_name TextField())
	elseif test_type == :Biaxial
md"""
Stress-1 Column: $(@bind stress1_column Select(names(df)))

Stress-2 Column: $(@bind stress2_column Select(names(df)))

Stretch-1 Column: $(@bind stretch1_column Select(names(df)))

Stretch-2 Column: $(@bind stretch2_column Select(names(df)))

"""	
# Stress Units: $(@bind stress_units TextField())

# Test Name: $(@bind test_name TextField())

	end
end

# ╔═╡ 12256359-1dca-4a71-a225-66994e2dfd66
begin
		if !isnothing(data)
			if test_type == :Uniaxial
				he_data = HyperelasticUniaxialTest(df[!, stretch_column],df[!, stress_column],  name = "experimental");
			elseif test_type == :Biaxial
				he_data = HyperelasticBiaxialTest(
					df[!, stretch1_column],
					df[!, stretch2_column],
					df[!, stress1_column],
					df[!, stress2_column], 
					name = "experimental");
			end
		end
	# map(model->Hyperelastics.parameter_bounds(model(), he_data), Base.Fix1(getfield, Hyperelastics).( hyperelastic_models));
end;

# ╔═╡ f12538a9-f595-4fae-b76c-078179bc5109
if @isdefined he_data
	if !isnothing(he_data) 
		HTML("""<center><h3 >Verification Plot</h3></center>""") 
	end
end

# ╔═╡ 2607b1b6-9c9c-482f-b38b-35e83a57f5d3
let
if @isdefined he_data
if !isnothing(he_data)
	if typeof(he_data) == HyperelasticUniaxialTest
		f, ax, p = scatter(
			getindex.(he_data.data.λ, 1), 
			getindex.(he_data.data.s, 1),
			axis = (
				xlabel = "Stretch", 
				ylabel = "Stress"
				), 
			label = "Experimental"
			)
		axislegend(position = :lt)
		f
	elseif typeof(he_data) == HyperelasticBiaxialTest
		f = Figure(resolution = 5.5 .*(200, 100), fonts = (;regular="Archivo Black"))
		ax1 = Makie.Axis(f[1, 1], xlabel = "λ₁ - Stretch", ylabel = "Stress [$(stress_units)]")
		ax2 = Makie.Axis(f[1, 2], xlabel = "λ₂ - Stretch", ylabel = "Stress [$(stress_units)]")
		scatter!(
			ax1, 
			getindex.(he_data.data.λ, 1), 
			getindex.(he_data.data.s, 1),
			label = "Nominal 1-direction"
		)
		scatter!(
			ax1, 
			getindex.(he_data.data.λ, 1),
			getindex.(he_data.data.s, 2),
			label = "Nominal 2-direction"
		)
		scatter!(
			ax2, 
			getindex.(he_data.data.λ, 2), 
			getindex.(he_data.data.s, 1),
			label = "Nominal 1-direction"
		)
		scatter!(
			ax2, 
			getindex.(he_data.data.λ, 2),
			getindex.(he_data.data.s, 2),
			label = "Nominal 2-direction"
		)
		axislegend(ax1, position = :lt)
		axislegend(ax2, position = :lt)
		f
	end
end
end
end

# ╔═╡ d0319d95-f335-48fa-b789-59daf9a0f1a4
if @isdefined he_data
	if !isnothing(he_data)
		HTML("""<center><h2 >Select Hyperelastic Model</h2></center>""") 
	end
end

# ╔═╡ 9343a51e-5002-4489-a55f-12c49f5b8cf3
if @isdefined he_data
if !isnothing(he_data)
md"""
!!! note "Note"
	- When selecting a phenomenological model, be aware that using higher order models may result in overfitting of the data.
	- All moduli in models are in the defined stress units above
"""
end
end

# ╔═╡ 2f1fde4b-6bd8-42b4-bf5c-d61006d55f10
if @isdefined he_data
if !isnothing(he_data) 
	@bind model Select(hyperelastic_models) 
end
end

# ╔═╡ da3634ea-48d7-4d4f-a853-c631a6fa7bf4
if @isdefined he_data
if !isnothing(he_data) 
	html"""<center><h3 > Model Information</h3></center>""" 
end
end

# ╔═╡ a75d209e-93cb-4b21-899e-4c567f0dfb09
if @isdefined he_data
	if !isnothing(he_data) eval(:(@doc $(getfield(Hyperelastics, model)()))) end
end

# ╔═╡ c6e726ab-ea78-4129-a662-338976633cd5
if @isdefined he_data
if !isnothing(he_data) 
	html"""<center><h2 style = "font-family:Archivo Black"> Set initial parameter guess</h2></center>""" 
end
end

# ╔═╡ 08d775f2-94fc-4ca8-bcdd-e9535cfd129a
if @isdefined he_data
if !isnothing(he_data) 
md"""
Optimizer: $(@bind optimizer Select([:LBFGS, :BFGS, :NelderMead])) - *If parameters are not converging, try using a different optimizer or changing your initial guess*
"""
end
end

# ╔═╡ 4d6f03c0-203a-4536-8ca2-c3dd77182ce6
function set_parameters(model,data)
	ψ = getfield(Hyperelastics, model)()
	ps = Hyperelastics.parameters(ψ)
	bounds = Hyperelastics.parameter_bounds(ψ, data)
	if isnothing(bounds.lb)
		lb = Dict(ps.=>-Inf)
	else 
		lb = Dict{Symbol, Float64}(pairs(bounds.lb))
	end
	if isnothing(bounds.ub)
		ub = Dict(ps.=>Inf)
	else 
		ub = Dict(pairs(bounds.ub))
	end
	
	return PlutoUI.combine() do Child
		inputs = [
			md"""$(string(p)) [ $(round(lb[p], digits = 3)) to $(round(ub[p], digits = 3)) ] $(Child(string(p), TextField()))"""
			for p in ps
		]
		md"""
		$(inputs)
		Fit Model: $(@bind fit_model CheckBox(default = false))
		"""
	end
end;

# ╔═╡ 703091d0-bf33-4baf-b75e-43e01b42ec0b
if @isdefined he_data
if !isnothing(he_data)
	@bind ps set_parameters(model, he_data)
end
end

# ╔═╡ d0713eb0-fe75-4ea4-bf20-2d4e9b722da5
if @isdefined he_data
if !isnothing(he_data)
			parsed, p₀ = try
				pair_ps = map(x->x.first => parse.(Float64, replace.(replace.(split(x.second, ","), " "=>""), ","=>"")), collect(pairs(ps)))
				ps = []
				for i in eachindex(pair_ps)
					if length(pair_ps[i].second) == 1
						push!(ps, pair_ps[i].first => pair_ps[i].second[1])
					else 
						push!(ps, pair_ps[i])
					end
				end
				true, ComponentVector(NamedTuple(ps))
			catch
				false, nothing
		end
end
end;

# ╔═╡ 1018d35f-42e9-4970-8a5f-f5cc6e951cbc
if @isdefined he_data
	if !isnothing(he_data)
		if parsed && fit_model
			ψ = getfield(Hyperelastics, Symbol(model))()
			heprob = HyperelasticProblem(ψ, he_data, p₀)
			opt = getfield(OptimizationOptimJL, optimizer)()
			solution = solve(heprob, opt)
			sol = NamedTuple(solution.u)
		end
	end
end;

# ╔═╡ 0fa152b1-462a-4f34-9753-13ef6ef63071
if @isdefined he_data
	if !isnothing(he_data)
		if !(isnothing(ps))
			if @isdefined sol
			str_table = let
				_str = "<span>"
				columns = string.(parameters(getfield(Hyperelastics, model)()))
				####################             HTML        #######################
				_str *= """<center><h2  style = "font-family:Archivo Black"> Final Parameters</h2></center>"""
				_str *= """<table>"""
				for column ∈ columns
					_str *=	"""<th>$(replace(column, "_" => " "))</th>"""
				end
				_str *= """<tr>"""
				for column ∈ columns
					_str *= """<td>$(round.(getfield(sol, Symbol(column)), sigdigits = 6))</input></td>"""
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
	end
end

# ╔═╡ 1345476c-ee08-4233-8506-0ebc94a2bec5
let
if @isdefined he_data
	if !isnothing(he_data)
		if parsed && fit_model
			if @isdefined sol
		ψ = getfield(Hyperelastics, Symbol(model))()
		ŷ = predict(ψ, he_data, sol)
		if typeof(he_data) == HyperelasticUniaxialTest
			Δs₁₃ = getindex.(ŷ.data.s, 1)
			λ₁ = getindex.(ŷ.data.λ, 1)
			s₁ = getindex.(he_data.data.s, 1)
			f = Figure()
			ax = CairoMakie.Axis(f,xlabel = "Stretch", xticks = 1:maximum(df[!, stretch_column]), ylabel = "Stress")
			s1 = scatter!(
				ax,
				λ₁,s₁,
			)
			l1 = lines!(
				ax,
				λ₁,
				Δs₁₃, 
				color = MakiePublication.seaborn_muted()[2],
			)
			axislegend(ax, [[s1], [l1]], ["Experimental", split(string(typeof(ψ)), ".")[2]], position = :lt)
			f[1,1] = ax
			f
		elseif typeof(he_data) == HyperelasticBiaxialTest
			Δs₁₃ = getindex.(ŷ.data.s, 1)
			Δs₂₃ = getindex.(ŷ.data.s, 2)
			λ₁ = getindex.(ŷ.data.λ, 1)
			λ₂ = getindex.(ŷ.data.λ, 2)
			s₁ = getindex.(he_data.data.s, 1)
			s₂ = getindex.(he_data.data.s, 2)
			fig = Figure(resolution = 5.5.*(200, 100))
			ax1 = CairoMakie.Axis(fig[1,1],xlabel = "λ₁ Stretch", ylabel = "Stress")
			ax2 = CairoMakie.Axis(fig[1,2],xlabel = "λ₂ Stretch", ylabel = "Stress")
			s11 = scatter!(
				ax1,
				λ₁,s₁,
			)
			s12 = scatter!(
				ax1,
				λ₁,s₂,
			)
			l11 = lines!(
				ax1,
				λ₁,
				Δs₁₃, 
				# color = MakiePublication.seaborn_muted()[2],
			)
			l12 = lines!(
				ax1,
				λ₁,
				Δs₂₃, 
				# color = MakiePublication.seaborn_muted()[2],
			)
			s21 = scatter!(
				ax2,
				λ₂,s₁,
			)
			s22 = scatter!(
				ax2,
				λ₂,s₂,
			)
			l21 = lines!(
				ax2,
				λ₂,
				Δs₁₃, 
			)
			l22 = lines!(
				ax2,
				λ₂,
				Δs₂₃, 
			)
			axislegend(ax1, [[s11], [s12], [l11], [l12]], [
				"Experimental - 1", 
				"Experimental - 2", 
				split(string(typeof(ψ)), ".")[2]*" - 1",
				split(string(typeof(ψ)), ".")[2]*" - 2",
			], position = :lt)
			axislegend(ax2, [[s21], [s22], [l21], [l22]], [
				"Experimental - 1", 
				"Experimental - 2", 
				split(string(typeof(ψ)), ".")[2]*" - 1",
				split(string(typeof(ψ)), ".")[2]*" - 2",
			], position = :lt)
			fig
		end

		end
		end
	end
end
end

# ╔═╡ 86f7e74f-c0a9-4561-85b9-f3ed6559facc
function ShearModulus(ψ, ps; adb = AD.ForwardDiffBackend())
	s(x) = AD.gradient(adb,x->StrainEnergyDensity(ψ, x, ps), x)[1][1]-AD.gradient(adb,x->StrainEnergyDensity(ψ, x, ps), x)[1][3]*x[3]
	AD.gradient(adb,y->s(y)[1], [1.0, 1.0, 1.0])[1][1]
end;

# ╔═╡ 8ea07dab-06dc-456d-9769-5e9c3980a777
ElasticModulus(ψ, ps) = ShearModulus(ψ, ps)*3;

# ╔═╡ 9441279c-49d9-4640-aca5-4576e6ee29ed
if @isdefined he_data
if !isnothing(he_data) && fit_model && @isdefined sol
	if parsed && !isnothing(he_data)
		HTML("""
		<center><h2  style = "font-family:Archivo Black"> Other Values </h2></center>
		<p  style = "font-family:Archivo Black">
		Small Strain Shear Modulus: $(round(ShearModulus(ψ, sol), digits = 3))
		<br>
		Small Strain Elastic Modulus: $(round(ElasticModulus(ψ, sol), digits = 3))
		</p>
		""")
	end
end
end

# ╔═╡ bcf0c08c-cc7a-4785-a87b-2be47633eb85
function model_note(ψ::Gent)
	return (
	μ = "Small strain shear modulus",
	Jₘ = "Limiting Stretch Invariant"
	)
end;

# ╔═╡ Cell order:
# ╟─0dd8b7de-570d-41a7-b83d-d1bbe39c017e
# ╟─73ab5774-dc3c-4759-92c4-7f7917c18cbf
# ╟─cac1e660-c03b-420a-b9bc-b4d4712ae325
# ╟─692b1d0d-2353-4931-b289-490f74988811
# ╟─69068002-ca3a-4e19-9562-6736d3b15dea
# ╟─f12538a9-f595-4fae-b76c-078179bc5109
# ╟─2607b1b6-9c9c-482f-b38b-35e83a57f5d3
# ╟─d0319d95-f335-48fa-b789-59daf9a0f1a4
# ╟─9343a51e-5002-4489-a55f-12c49f5b8cf3
# ╟─2f1fde4b-6bd8-42b4-bf5c-d61006d55f10
# ╟─da3634ea-48d7-4d4f-a853-c631a6fa7bf4
# ╟─a75d209e-93cb-4b21-899e-4c567f0dfb09
# ╟─c6e726ab-ea78-4129-a662-338976633cd5
# ╟─703091d0-bf33-4baf-b75e-43e01b42ec0b
# ╟─08d775f2-94fc-4ca8-bcdd-e9535cfd129a
# ╟─1018d35f-42e9-4970-8a5f-f5cc6e951cbc
# ╟─0fa152b1-462a-4f34-9753-13ef6ef63071
# ╟─1345476c-ee08-4233-8506-0ebc94a2bec5
# ╟─9441279c-49d9-4640-aca5-4576e6ee29ed
# ╟─7196aa51-e86d-4f0e-ae40-cc6aa74aa237
# ╟─9e411ed3-0061-4831-b047-44c920959c83
# ╟─e5a18d4c-14cd-11ed-36d5-69de0fd02830
# ╟─2d189645-189f-4886-a6d5-5718a613798f
# ╟─d495c5e5-bf33-475c-a49a-5c9f8dc13789
# ╟─6f061996-be32-493d-80e2-daedec8bb103
# ╟─e0e7407d-fe60-4583-8060-3ba38c22c409
# ╟─7998136a-de3d-42f9-9028-1172415c8b75
# ╟─12256359-1dca-4a71-a225-66994e2dfd66
# ╟─4d6f03c0-203a-4536-8ca2-c3dd77182ce6
# ╟─d0713eb0-fe75-4ea4-bf20-2d4e9b722da5
# ╟─86f7e74f-c0a9-4561-85b9-f3ed6559facc
# ╟─8ea07dab-06dc-456d-9769-5e9c3980a777
# ╟─bcf0c08c-cc7a-4785-a87b-2be47633eb85
