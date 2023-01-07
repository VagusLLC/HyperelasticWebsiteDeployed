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

# ╔═╡ 511a9463-65eb-4ac0-baff-f8c386638c54
begin
	local_dir = joinpath(splitpath(@__FILE__)[1:end-1])
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add(
		[
		Pkg.PackageSpec(name="Unitful"),
		Pkg.PackageSpec(name="Latexify"),
		Pkg.PackageSpec(name="RecursiveArrayTools"),
		Pkg.PackageSpec(name="Distributions"),
		Pkg.PackageSpec(name="ModelingToolkit"),
		Pkg.PackageSpec(name="PlotlyLight"),
		Pkg.PackageSpec(name="Surrogates"),
		Pkg.PackageSpec(name="Measurements"),
		Pkg.PackageSpec(name="DifferentialEquations"),
		Pkg.PackageSpec(name="Animations"),
		Pkg.PackageSpec(name="BlackBoxOptim"),
		Pkg.PackageSpec(name="ControlSystems"),
		Pkg.PackageSpec(name="Optim"),
		Pkg.PackageSpec(name="DataDrivenDiffEq"),
		Pkg.PackageSpec(name="LaTeXStrings"),
		Pkg.PackageSpec(name="DiffEqParamEstim"),
		Pkg.PackageSpec(name="DynamicalSystems"),
		Pkg.PackageSpec(name="MonteCarloMeasurements"),
		# Pkg.PackageSpec(name="Javis"),
		Pkg.PackageSpec(name="Colors"),
		Pkg.PackageSpec(name="PlutoUI"),
		# Pkg.PackageSpec(name="JavisNB"),
		]
	)
	Pkg.develop([
		Pkg.PackageSpec(path=joinpath(local_dir, "BondGraphs")),
	])
	using Unitful,Latexify, RecursiveArrayTools, LinearAlgebra, Distributions, ModelingToolkit, PlotlyLight, Surrogates, Measurements, DifferentialEquations, Animations, BlackBoxOptim, ControlSystems, Optim, MonteCarloMeasurements, BondGraphs, DataDrivenDiffEq, LaTeXStrings, DiffEqParamEstim, DynamicalSystems, Statistics,	Colors, PlutoUI
	using Javis, JavisNB
end

# ╔═╡ d3060600-ffd4-4668-925e-cc89e665ae39
html"<button onclick='present()'>present</button>"

# ╔═╡ 03454da0-2b50-43b1-9c42-af17ad2ce9e1
begin
function WidthOverDocs(enabled=false, offset = 30)
	checked = enabled ? "checked" : ""
	init = enabled ? "toggle_width(document.getElementById('width-over-livedocs'))" : ""
	return HTML("""
<!-- https://github.com/fonsp/Pluto.jl/issues/400#issuecomment-695040745 -->
<input
	type="checkbox"
	id="width-over-livedocs"
	name="width-over-livedocs"
    onclick="window.plutoOptIns.toggle_width(this)"
	$(checked)>
<label for="width-over-livedocs">
	Activate bigger width - hiding live docs
</label>
<style>
	body.width-over-docs #helpbox-wrapper {
    	display: none !important;
	}
	body.width-over-docs main {
		max-width: calc(100% - $(offset)rem);
		margin-right: $(offset)rem;
	}
</style>
<script>
	const toggle_width = function(t) {
		t.checked
		? document.body.classList.add("width-over-docs")
		: document.body.classList.remove("width-over-docs")
	}
	window.plutoOptIns = window.plutoOptIns || {}
	window.plutoOptIns.toggle_width = toggle_width
	$(init)
</script>
""")
end
md"""
Enable Table of Contents $(@bind TOC CheckBox())
"""
end

# ╔═╡ f10215ec-2ddb-4764-b03e-f567a2e41d81
HTML("""
<center><h1>I³-LIB Engineering Textbooks</h1></center>
<center><h3>Integrated, Interactive, Internet-Based Techonology for Lab-in-Book Engineering Textbooks</h3><center>
<h6><b>Dr. Hector Medina (CEO Vagus), Carson Farmer (COO Vagus)</b></h6>
<center> <img src="https://github.com/cfarm6/BondGraphPictures/raw/main/images/roadmap.png" style="width:833px;height:493.5px;"> <center>
""")

# ╔═╡ 96c84fc8-8731-49dc-8ff3-6a9e7aa5c30e
md"""
# 1. Dynamic Systems Modeling, Simulation, and Control of Mechatronic Systems Using Bond Graphs
"""

# ╔═╡ 8b9b4121-d42d-420a-b18e-b345f70df1db
md"""
The study of dynamic systems is critical to the engineering profession. Essentially, all (natural and engineering) systems change in time, therefore, the understanding of the elements of dynamic systems modeling, simulation, and control is very important in engineering design.
"""

# ╔═╡ c23bbe41-9b5f-4834-b19e-8ebb73c5e4f0
Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/domain_systems_new.png")

# ╔═╡ eb458bd2-4add-4c50-a95b-913bc849bcfa
md"""
# 2. Introduction to Bond Graphs
"""

# ╔═╡ 82c777cd-4fc1-4ba7-a06a-382d79c7e0cd
html"""<img src="https://github.com/cfarm6/BondGraphPictures/raw/main/images/half_car.png" style="width:646px;height:444px;" align = left>"""

# ╔═╡ 618735ce-bf2e-405e-b57c-0d9516e4da0a
md"""
## Bond Graph Variables and Components
- One of the advantages of using bond graph approach is that it relies on a relatively small number of symbols to represent a large variety of engineering systems.
- Both engineering professionals and students often find it cumbersome to communicate using schematics from other engineering disciplines due to, partially, the learning curve associated with new symbols.
- One could think of the bond graph approach as a type of "Rosetta Stone", which allows the learning of new engineering domains via generalized concepts and symbols.
- Not only the students learn concepts related to other energy domains, but also they are exposed to actual modeling, simulation, and control of multi-energy domain systems
| Bond Graph | Mechanical | Electrical | Hydraulic | Chemical | Equations |
| :--------: | :--------: | :--------: | :-------: | :------: | :-------: |
| Potential ($e$) | Force, $F$ $[N]$ | Voltage, $V$ $[V]$ | Pressure, $P$ $[Pa]$ | Chemical Potential $\mu$ $\bigg[\frac{J}{mol}\bigg]$ | $\frac{d}{dt} p$ |
| Flow ($f$) | Velocity, $v$ $\bigg[\frac{m}{s}\bigg]$ | Current, $I$ $[A]$ | Volume Flow, $Q$ $\bigg[\frac{m^3}{s}\bigg]$ | Molar Flow Rate $\nu$ $\bigg[\frac{mol}{s}\bigg]$ | $\frac{d}{dt} q$ |
| Discplacement ($q$) | Displacement, $x$ $[m]$ | Charge, $Q$ $[C]$ | Volume $V$ $[m^3]$ | Moles $[mol]$| $\int f\ dt$ |
| Momentum ($p$) | Momentum, $p$ $\bigg[\frac{kg\ \cdot\ m}{s}\bigg]$ | Flux Linkage, $\lambda$ $[V\cdot s]$ | Pressure Momentum, $p_p$ $\bigg[\frac{N\ \cdot\ s}{m^3}\bigg]$ | Chemical Momentum $\bigg[\frac{J\ \cdot\ s}{mol}\bigg]$| $\int e\ dt$ | 
| Resistor ($R$) | Damper | Resistor | Pipe | Reaction | $e = \Phi_R(f)$ |
| Capactor ($C$) | Spring | Capcitor | Tank | Chemical Species | $f = \frac{d}{dt}\Phi_C(e)$ |
| Inertia ($I$) | Mass | Inductor | Mass | - | $e = \frac{d}{dt}\Phi_I(f)$ |
| Memristance ($M$) | - | Memristor | - | - | $p = \Phi_M(q)$ |
| Effort Source ($S_e$) | Applied Force | Voltage Source | Pressure Source | Chemostat | $e = S_e(t)$ |
| Flow Source ($S_f$)| Applied Velocity | Current Source | Flow Source | - | $f = S_f(t)$ |
| Transform ($TF$) | Lever | Transformer | Pressure Transformer | Stoichiometry | $e_1 = \Phi_{TF}(e_2)$, $f_2 = \Phi^{-1}_{TF}(f_1)$ |
| Gyrator ($GY$) | Gyroscope | Hall Effect | - | - | $e_1 = \Phi_{GY}(f_2)$, $e_2 = \Phi_{GY}(f_1)$ |
| Effort Junction ($0$) | Series Connection | Parallel Connection | Parallel Connection | Common Species | $\sum_{j=0}^{N}f_j = 0$, $e_i = e_j \ \ \forall i, j \in {1,..., N}$
| Flow Junction ($1$) | Parallel Connection | Series Connection | Series Connection | Reactant/Product Complexes | $\sum_{j=0}^{N}e_j = 0$, $f_i = f_j \ \ \forall i, j \in {1,..., N}$
"""

# ╔═╡ 677df42f-b439-4b0e-ae81-4a724fb2d971
md"""
## Bond Graph Domains and Examples
- In traditional dynamic systems courses and approaches, the engineering students most likely learn only about their particular engineering system domain.
- As previously mentioned, the bond graph approach facilitates the integration of multiple domains, which is more suitable for modern robotics and interdisciplinary system analysis. 
"""

# ╔═╡ 197bb937-cae3-4142-a68a-7beee63fac4c
Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/multi_domain_bond_graphs_new.png")

# ╔═╡ 5a130c47-a151-41a6-8cce-42388b9513fa
md"""
# 3. Introduction to I³-Lib Tool as Applied to Bond Graphs
1. Instructor perspective
2. Student interaction
"""

# ╔═╡ 9a532355-5b2b-4c89-9e1c-a31bec2dd575
md"""
## Mass Spring Damper
!!! tip " Lumped System Representations "
	- Lumped idealized models are ubiquitous in engineering pedagogy. They are very useful to represent either devices or effects.
	- For example, the well-known mass spring damper system shown below can be used to model a variety of mechanical systems such as suspension systems for vehicles, landing gear for aircraft, and even aircraft flight disturbances, just to name a few. 
	- A bond graph representation of the mass spring damper system is show on the right in the figure below.
	- From the bond graph, first order differential equations can be directly derived. Manipulation of these equations provides students with insight in the behavior of the system to different stimuli.
"""

# ╔═╡ 0e113ade-bac7-4088-97f9-019b95fbfd72
Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/msd_airplace.png")

# ╔═╡ 4aea0fc8-8b26-4a3f-883c-392f9e714c68
md"""
### Equations from BondGraph
"""

# ╔═╡ a218d7b0-28d5-4855-bbec-132eaa42ec40
let
	# Make Time Variable
	@variables t
	# Make Bond Graph
	msd = BondGraph(t, :msd)
	# Add Bond Graph Elements
	add_I!(msd, :m)
	add_C!(msd, :k)
	add_R!(msd, :b)
	add_Se!(msd, :Fc)
	# Add 1-Junction
	add_1J!(msd, Dict(
		:m => false,
		:k => false,
		:b => false,
		:Fc => true
		), :J1)
	# Generate Model
	# sys = generate_model(msd)
	sys = BondGraphs.graph_to_model(msd)
	sys = structural_simplify(sys)
	# Print Latex Equation
	LaTeXString.(replace.(latexify(full_equations(sys)), "{\\_+}" => "_{+}"))
end

# ╔═╡ 6bc65d66-234e-43db-84ad-562121493a8a
md"""
## Chemical Reaction Network
!!! tip "Systems Biology"
	- Recently, bond graphs are being used to present different biological phenomena. 
	- Bond graphs allow biology researchers to connect models for different chemical process easily and in a way that allows for interpretability. 
	- The bond graph representation closely matches the chemical diagram for a model but contains for information for deriving the equations. 
"""

# ╔═╡ 3dac7556-2226-46c5-b2fa-2650323a8c22
Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/chemical.png")

# ╔═╡ abbef45c-3c9d-4dfb-a3b2-a7150e2252bf
md"""
### Equations from BondGraph
"""

# ╔═╡ 0e5e89e6-909e-4781-9817-682bc82fdc33
let 
	# Create Time Variable
	@variables t
	# Create Bond Graph
	xyz = BioBondGraph(t, :xyz, R = 8.314, T = 310.0)
	# Add species
	add_Ce!(xyz, :X)
	add_Ce!(xyz, :Y)
	add_Ce!(xyz, :Z)
	# Add Bonds
	for i = 1:6
    	add_Bond!(xyz, Symbol("b" * string(i)))
	end
	# Add Reactions
	add_Re!(xyz, :b1, :b2, :XY)
	add_Re!(xyz, :b3, :b4, :YZ)
	add_Re!(xyz, :b5, :b6, :ZX)
	# Add 0-Junctions
	add_0J!(xyz,
     	Dict(
        	:X => false,
        	:b6 => true,
        	:b1 => false
		), :J0X)
	add_0J!(xyz,
    	Dict(
        	:Y => false,
       		:b2 => true,
        	:b3 => false
		), :J0Y )
	add_0J!(xyz,
    	Dict(
        	:Z => false,
        	:b4 => true,
        	:b5 => false
		), :J0Z )
	# Generate Model
	sys = generate_model(xyz)
	# LaTeXString.(replace.(latexify(full_equations(sys)), "{\\_+}" => "_{+}"))
end

# ╔═╡ 99d1f985-11c9-4afc-b4c0-d9033217a291
md"""
## State-Space Representations for Activate Quater Car Suspension
!!! tip "Linear Representations of Systems"
	- For linear systems, once the bond graph has been created, a state-space representation is derived. 
	- State-space representations of dynamic systems allow for a mathematical analysis of the system behavior
	- Student leverage skills from mathematics and engineering to determine the stability and controlability of the system
"""

# ╔═╡ e35b9427-5940-41dd-8d4c-5f3f23cac61f
md"""
### State-Space Representation
$\dot{\vec{x}} = [A]\vec{x}+[B]\vec{u}$    
$\vec{y} = [C]\vec{x}+[D]\vec{u}$
where $x$ is the vector of states, $u$ is the vector of inputs, $y$ is the vector of observables
"""

# ╔═╡ 549d0da7-fa71-446e-8e6c-89fa5bc641ee
md"""
#### A and B -Matrices
"""

# ╔═╡ b81438fb-78b1-4b3b-afa8-16a18fd7001f
let 
	## Create BondGraph Object
	@parameters t
	car = BondGraph(t,:car)
	## Add Elements
	# Input Velocity
	add_Sf!(car, :Sf)
	# Control Velocity
	add_Se!(car, :Se)
	# Masses
	add_I!(car, :m)
	add_I!(car, :mc)
	# Dampers
	add_R!(car, :b)
	add_R!(car, :bc)
	# Springs
	add_C!(car, :k)
	add_C!(car, :kc)
	# Resistor
	add_R!(car, :R)
	# Miscellaneous Bonds
	for b in Symbol.("b" .* ["2", "5", "7", "9", "12", "13"])
	    add_Bond!(car, b)
	end
	## Two-Ports
	add_GY!(car, :b13, :b12, :τc)
	## Junctions
	add_1J!(car, Dict(
        :b => false,
        :k => false,
        :b2 => true
    	), :J11)
	add_0J!(car, Dict(
        :Sf => true,
        :b2 => false,
        :b5 => false
    	), :J01)
	add_1J!(car, Dict(
        :b5 => true,
        :m => false,
        :b7 => false
    	), :J12)
	add_0J!(car, Dict(
        :b7 => true,
        :b9 => false,
        :mc => false
    	), :J02)
	add_1J!(car, Dict(
        :b9 => true,
        :bc => false,
        :b12 => true,
        :kc => false
    	), :J13)
	add_1J!(car, Dict(
        :Se => true,
        :R => false,
        :b13 => false
    	), :J14)
	## Generate the model
	sys = generate_model(car)
	sys = structural_simplify(sys)
	A, B, C, D, states_dict, inputs_dict, observed_dict = state_space(car, sys)
	index_dict = Dict([states_dict[x]=>x for x in keys(states_dict)])
	x_vec = vcat([index_dict[x] for x in 1:size(A)[2]]...)
	index_dict = Dict([inputs_dict[x]=>x for x in keys(inputs_dict)])
	u_vec = vcat([index_dict[x] for x in 1:size(B)[2]]...)
	A = replace.(latexify(A), "{\\_+}" => "_{+}")
	B = replace.(latexify(B), "{\\_+}" => "_{+}")
	x_vec = replace.(latexify(x_vec), "{\\_+}" => "_{+}")
	u_vec = replace.(latexify(u_vec), "{\\_+}" => "_{+}")
	latexstring("A=", A), latexstring("\\vec{x}=",x_vec), latexstring("B=", B), latexstring("\\vec{u}=",u_vec)
end

# ╔═╡ 5228d2a5-e1b3-4964-b876-5b83b281809b
md"""
# 4. Interactive Elements for Student Learning
"""

# ╔═╡ ee966448-556b-4ce1-980e-8b65e80d556e
html"<button onclick='present()'>present</button>"

# ╔═╡ 14f2de65-f15f-4759-8fc4-6844c0cd2de4
md"""
## Example 4.1: Creation of the Bond Graph
- In order to create the bond graph, students are prompted to add information about the bond graph and the tool derives the equations.
- A drag and drop version of this creation step is in alpha stage.
"""

# ╔═╡ 81a48fa2-d497-4934-bbfa-23f53212bc47
html"""<center> <img src="https://github.com/cfarm6/BondGraphPictures/raw/main/images/msd.png"> <center>"""

# ╔═╡ 4269cc94-40b8-4cb8-8042-2a257532b3a0
md"""
Number of Bond Graph Elements: $(@bind num_elem NumberField(1:100))
"""

# ╔═╡ d42d451b-e1df-444e-af25-e4dd0346f17e
begin
	str = let
	_str = "<span>"
	columns = ["Element", "Name", "Connections", "Parameter", "Derivative_Causality"]
	output_string = "{"
	for column ∈ columns
		output_string *= """$(column):Array("""
		for i ∈ 1:num_elem
			if column == "Derivative_Causality"
				output_string *= """$(column)_$(i).checked,"""
			else
				output_string *= """$(column)_$(i).value,"""
			end
		end
		output_string *= """), """
	end
	output_string *= "make_model: make_model.checked, p_sub: p_sub.checked"
	output_string *= """}"""
####################             HTML        ##############################
	_str *= """<center><h5> Bond Graph Entry</h5></center>"""
	_str *= """<table>"""
	for column ∈ columns
		_str *=	"""<th>$(replace(column, "_" => " "))</th>"""
	end
	for i ∈ 1:num_elem
		_str *= """<tr>"""
		for column ∈ columns
			if column == "Derivative_Causality"
				_str *= """<td><input type = "checkbox" id = "$(column)_$(i)"></input></td>"""
			else
				_str *= """<td><input type = "text" id = "$(column)_$(i)"></input></td>"""
			end
		end
		_str *= """</tr>"""
	end
	_str *= """<tfoot><tr><td></td><td>Make Model:<input type = "checkbox" id = "make_model"></input></td>"""
	_str *= """<td>Substitute Parameters: <input type = "checkbox" id = "p_sub"</td></tr></tfoot>"""
	_str *= """</table>"""
######################        JAVASCRIPT            ####################
	_str *= """
		<script>		
			var span = currentScript.parentElement
		"""
	for i ∈ 1:num_elem
		for column ∈ columns
		_str*="""
			var $(column)_$(i) = document.getElementById("$(column)_$(i)")
		
			$(column)_$(i).addEventListener("input", (e) => {
				span.value = $(output_string)
				span.dispatchEvent(new CustomEvent("input"))
				e.preventDefault()
			})
		"""
		end
		
	end
	for i ∈ ["make_model", "p_sub"]
		_str*="""
			var $(i) = document.getElementById("$(i)")
			$(i).addEventListener("input", (e) => {
				span.value = $(output_string)
				span.dispatchEvent(new CustomEvent("input"))
				e.preventDefault()
			})
		"""
	end
	_str*="""
		span.value = $(output_string)
		</script>
		</span>
		"""
	end
	@bind r HTML(str)
end

# ╔═╡ 416bd3ab-bfd6-4470-a1d4-3e577b037421
let
	if r["make_model"]
		@variables t
		bg = BondGraph(t, :bg)
		# Recreate one-port elements
		# Get Se - Elements
		se_index = filter(x->r["Element"][x]=="Se", eachindex(r["Element"]))
		map(x->add_Se!(bg, Symbol(r["Name"][x])), se_index)
		# Get Sf - Elements
		sf_index = filter(x->r["Element"][x]=="Sf", eachindex(r["Element"]))
		map(x->add_Sf!(bg, Symbol(r["Name"][x])), sf_index)
		# Get R - Elements
		R_index = filter(x->r["Element"][x]=="R", eachindex(r["Element"]))
		map(x->add_R!(bg, Symbol(r["Name"][x])), R_index)
		# Get C - Elements
		C_index = filter(x->r["Element"][x]=="C", eachindex(r["Element"]))
		map(x->add_C!(bg, Symbol(r["Name"][x])), C_index)
		# Get I - Elements
		I_index = filter(x->r["Element"][x]=="I", eachindex(r["Element"]))
		map(x->add_I!(bg, Symbol(r["Name"][x])), I_index)
		# Get 1-Junctions
		J1_index = filter(x->r["Element"][x]=="1J", eachindex(r["Element"]))
		bond_counter = 0
		J1_dirs = let
					dirs = Dict{Symbol, Dict{Symbol, Bool}}()
			    	for J1 in J1_index
				    	# Get Out-Elements
				    	out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][J1], ","), eachindex(r["Name"]))
			    		# Outward-connection to other non one port elements
			    		junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J" || r["Element"][x] == "GY" || r["Element"][x] == "TF"), out_index)			
			    		for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][jc])
							r["Connections"][J1] = replace(r["Connections"][J1], r["Name"][jc] => "B$(bond_counter)")
							bond_counter += 1
			    		end
						out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][J1], ","), eachindex(r["Name"]))
			    		out_sym = Symbol.(r["Name"][out_index])
			    		# Get In-Elemnts
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][J1]), eachindex(r["Element"]))
						junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J"|| r["Element"][x] == "GY" || r["Element"][x] == "TF"), in_index)			
						for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][J1])
							r["Connections"][jc] = replace(r["Connections"][jc], r["Name"][J1] => "B$(bond_counter)")
							bond_counter += 1
						end
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][J1]), eachindex(r["Element"]))
			    		in_sym = Symbol.(r["Name"][in_index])
			    		# Create Direction Dictionary
			    		dirs[Symbol(r["Name"][J1])] = Dict([out_sym.=>false; in_sym.=>true])
			    	end
					dirs
				end
		# # Get 0-Junctions
		J0_index = filter(x->r["Element"][x]=="0J", eachindex(r["Element"]))
		J0_dirs = let
					dirs = Dict{Symbol, Dict{Symbol, Bool}}()
			    	for J0 in J0_index
				    	# Get Out-Elements
				    	out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][J0 ], ","), eachindex(r["Name"]))
			    		# Outward-connection to other non one port elements
			    		junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J"|| r["Element"][x] == "GY" || r["Element"][x] == "TF"), out_index)			
			    		for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][jc])
							r["Connections"][J0] = replace(r["Connections"][J0], r["Name"][jc] => "B$(bond_counter)")
							bond_counter += 1
			    		end
						out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][J0], ","), eachindex(r["Name"]))
			    		out_sym = Symbol.(r["Name"][out_index])
			    		# Get In-Elemnts
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][J0]), eachindex(r["Element"]))
						junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J"|| r["Element"][x] == "GY" || r["Element"][x] == "TF"), in_index)			
						for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][J0])
							r["Connections"][jc] = replace(r["Connections"][jc], r["Name"][J0] => "B$(bond_counter)")
							bond_counter += 1
						end
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][J0]), eachindex(r["Element"]))
			    		in_sym = Symbol.(r["Name"][in_index])
			    		# Create Direction Dictionary
			    		dirs[Symbol(r["Name"][J0])] = Dict([out_sym.=>false; in_sym.=>true])
			    	end
					dirs
				end
		# # Get GY - Elements
		GY_index = filter(x->r["Element"][x]=="GY", eachindex(r["Element"]))
		bond_counter = 0
		GY_dirs = let
					dirs = Dict{Symbol, Dict{Symbol, Symbol}}()
			    	for GY in GY_index
				    	# Get Out-Elements
				    	out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][GY], ","), eachindex(r["Name"]))
			    		# Outward-connection to other non one port elements
			    		junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J"|| r["Element"][x] == "GY" || r["Element"][x] == "TF"), out_index)			
			    		for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][jc])
							r["Connections"][GY] = replace(r["Connections"][GY], r["Name"][jc] => "B$(bond_counter)")
							bond_counter += 1
			    		end
						out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][GY], ","), eachindex(r["Name"]))
			    		out_sym = Symbol.(r["Name"][out_index])
			    		# Get In-Elemnts
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][GY]), eachindex(r["Element"]))
						junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J"|| r["Element"][x] == "GY" || r["Element"][x] == "TF"), in_index)			
						for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][GY])
							r["Connections"][jc] = replace(r["Connections"][jc], r["Name"][GY] => "B$(bond_counter)")
							bond_counter += 1
						end
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][GY]), eachindex(r["Element"]))
			    		in_sym = Symbol.(r["Name"][in_index])
			    		# Create Direction Dictionary
			    		dirs[Symbol(r["Name"][GY])] = Dict([:out => out_sym[1], :in => in_sym[1]])
			    	end
					dirs
				end
		# # Get TF - Elements
		TF_index = filter(x->r["Element"][x]=="TF", eachindex(r["Element"]))
		bond_counter = 0
		TF_dirs = let
					dirs = Dict{Symbol, Dict{Symbol, Symbol}}()
			    	for TF in TF_index
				    	# Get Out-Elements
				    	out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][TF], ","), eachindex(r["Name"]))
			    		# Outward-connection to other non one port elements
			    		junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J"|| r["Element"][x] == "GY" || r["Element"][x] == "TF"), out_index)			
			    		for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][jc])
							r["Connections"][TF] = replace(r["Connections"][TF], r["Name"][jc] => "B$(bond_counter)")
							bond_counter += 1
			    		end
						out_index = filter(x->r["Name"][x] ∈ split(r["Connections"][TF], ","), eachindex(r["Name"]))
			    		out_sym = Symbol.(r["Name"][out_index])
			    		# Get In-Elemnts
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][TF]), eachindex(r["Element"]))
						junction_connections = filter(x->(r["Element"][x] == "1J" || r["Element"][x] == "0J"|| r["Element"][x] == "GY" || r["Element"][x] == "TF"), in_index)			
						for jc ∈ junction_connections
					    	push!(r["Element"], "B")
				    		push!(r["Name"], "B$(bond_counter)")
					    	push!(r["Connections"], r["Name"][TF])
							r["Connections"][jc] = replace(r["Connections"][jc], r["Name"][TF] => "B$(bond_counter)")
							bond_counter += 1
						end
			    		in_index = filter(x->contains(r["Connections"][x], r["Name"][TF]), eachindex(r["Element"]))
			    		in_sym = Symbol.(r["Name"][in_index])
			    		# Create Direction Dictionary
			    		dirs[Symbol(r["Name"][TF])] = Dict([:out => out_sym[1], :in => in_sym[1]])
			    	end
					dirs
				end
		# # # Get Bond - Elements
		B_index = filter(x->r["Element"][x]=="B", eachindex(r["Element"]))
		map(x->add_Bond!(bg, Symbol(r["Name"][x])), B_index)
		for k ∈ collect(keys(TF_dirs))
			add_TF!(bg, TF_dirs[k][:in], TF_dirs[k][:out], k)
		end
		for k ∈ collect(keys(GY_dirs))
			add_GY!(bg, GY_dirs[k][:in], GY_dirs[k][:out], k)
		end
		for k ∈ collect(keys(J0_dirs))
			add_0J!(bg, J0_dirs[k], Symbol(k))
		end
		for k ∈ collect(keys(J1_dirs))
			add_1J!(bg, J1_dirs[k], Symbol(k))
		end
		if r["p_sub"]
			map(x->bg[Symbol(r["Name"][x])].I = parse(Float64, r["Parameter"][x]), I_index)
			map(x->bg[Symbol(r["Name"][x])].R = parse(Float64, r["Parameter"][x]), R_index)
			map(x->bg[Symbol(r["Name"][x])].C = parse(Float64, r["Parameter"][x]), C_index)
			map(x->bg[Symbol(r["Name"][x])].m = parse(Float64, r["Parameter"][x]), TF_index)
			map(x->bg[Symbol(r["Name"][x])].r = parse(Float64, r["Parameter"][x]), GY_index)

		end
		sys = generate_model(bg)
		sys = structural_simplify(sys)
		if r["p_sub"]
			eqs = full_equations(sys)
			eqs = Symbolics.simplify.(substitute.(eqs, (sys.defaults,)))
			@named sys = ODESystem(eqs, sys.iv)
		end
		LaTeXString.(replace.(latexify(BondGraphs.remove_algebraic(bg, sys)[1]), "{\\_+}" => "_{+}"))
	end
end

# ╔═╡ 1db6c69a-0ce0-4ed7-b0a2-df35f610b241
md"""
## Example 4.2: Solving Differential Equations and Interactivity
### Chemical Reactions: 
`math 
X\leftrightharpoons Y\leftrightharpoons Z\leftrightharpoons X
`
!!! tip "Example Chemical System"
	- The model describes the a generic chemical reaction. This model is similar to that for an enzyme-catalysed reaction. 
	- Enzyme-catalyzed reaction are common in predicting the behavior of MAPK Pathways, which controls the creation of DNA.
"""

# ╔═╡ 87deb82f-1fde-4479-a7c6-1d3010edcc87
chem_bond_graph, chem_prob, chem_model, chem_u0, chem_ps = let
	@parameters t
	chem = BioBondGraph(t, :chem, R = 8.314, T = 310.0)
	add_Ce!(chem, :X)
	add_Ce!(chem, :Y)
	add_Ce!(chem, :Z)
	# Add Building Bonds
	for i = 1:6
    	add_Bond!(chem, Symbol("b" * string(i)))
	end
	# Add Reactions
	add_Re!(chem, :b1, :b2, :XY)
	add_Re!(chem, :b3, :b4, :YZ)
	add_Re!(chem, :b5, :b6, :ZX)
	# Add 0-Junctions
	add_0J!(chem,
	    Dict(
    	    :X => false,
        	:b6 => true,
        	:b1 => false
    	),
    	:J0X
	)
	add_0J!(chem,
	    Dict(
    	    :Y => false,
        	:b2 => true,
        	:b3 => false
    	),
    	:J0Y
	)
	add_0J!(chem,
	    Dict(
    	    :Z => false,
        	:b4 => true,
        	:b5 => false
    	),
    	:J0Z
	)
	generate_model!(chem)
	# Set Parameters
	ps = [
    	chem[:X].k => 1.0,
    	chem[:Y].k => 2.0,
    	chem[:Z].k => 3.0,
    	chem[:XY].r => 1.0,
    	chem[:YZ].r => 2.0,
    	chem[:ZX].r => 3.0,
	]|>Dict
	# Set Timespan
	tspan = (00.0, 0.3)
	# Set Initial Conditions
	u0 = [
	    chem[:X].q => 2.0,
	    chem[:Y].q => 2.0,
	    chem[:Z].q => 2.0
	]|>Dict
	# Create ODE Problem
	prob = ODEProblem(chem.model, u0, tspan, ps)
	chem, prob, chem.model, u0, ps
end;

# ╔═╡ d6717b74-a638-4551-891a-2f14349a4769
LaTeXString.(replace.(latexify(full_equations(chem_bond_graph.model)), "{\\_+}" => "_{+}"))

# ╔═╡ 5678ff7f-b168-4798-802d-63e4eb6742d5
begin
	x_q_slider = @bind x_q Slider(0:10, default = 2)
	y_q_slider = @bind y_q Slider(0:10, default = 5)
	z_q_slider = @bind z_q Slider(0:10, default = 8)
	xy_r_slider= @bind xy_r Slider(0:10,default = 2)
	yz_r_slider = @bind yz_r Slider(0:10,default = 5)
	zx_r_slider = @bind zx_r Slider(0:10,default = 8)
	x_k_slider = @bind x_k Slider(0:10,default = 2)
	y_k_slider = @bind y_k Slider(0:10,default = 5)
	z_k_slider = @bind z_k Slider(0:10,default = 8)
end;

# ╔═╡ 0dfb115e-d5c7-401c-8664-7e0dd08e43e1
let
	# Set Initial Conditions
	chem_u0[chem_bond_graph[:X].q] = x_q
	chem_u0[chem_bond_graph[:Y].q] = y_q
	chem_u0[chem_bond_graph[:Z].q] = z_q
	chem_ps[chem_bond_graph[:XY].r] = xy_r
	chem_ps[chem_bond_graph[:YZ].r] = yz_r
	chem_ps[chem_bond_graph[:ZX].r] = zx_r
	chem_ps[chem_bond_graph[:X].k] = x_k
	chem_ps[chem_bond_graph[:Y].k] = y_k
	chem_ps[chem_bond_graph[:Z].k] = z_k
	chem_prob = remake(chem_prob, u0 = ModelingToolkit.varmap_to_vars(chem_u0, states(chem_model)), p = ModelingToolkit.varmap_to_vars(chem_ps, ModelingToolkit.parameters(chem_model)))
	## Solve the system
	sol = solve(chem_prob, Tsit5(), saveat=0.001)
	x_data = Config(x=sol.t, y = sol[chem_bond_graph[:X].q], name = "X₊q", mode = "lines", line = Config(color=:red))
	y_data = Config(x=sol.t, y = sol[chem_bond_graph[:Y].q], name = "Y₊q", mode = "lines",  line = Config(color=:blue))
	z_data = Config(x=sol.t, y = sol[chem_bond_graph[:Z].q], name = "Z₊q", mode = "lines", line = Config(color=:green))
	p = Plot([x_data, y_data, z_data])
	p.layout = Config(
		xaxis = Config(
			title = "Time [s]",
			mirror = true,
			ticks="outside",
			showline=true,
			zeroline=false
		),
		yaxis = Config(
			title = "Species Amount [mol]",
			mirror = true,
			ticks="outside",
			showline=true,
			zeroline=false
		),
	)
	p
end

# ╔═╡ 539584e5-0018-4620-a310-21449d2baaef
md"""
## Example 4.3: Rotating Airplane
"""

# ╔═╡ 1b0c8c7f-9e25-44a9-84b5-d8be12b67ee3
md"""
!!! tip "Comments"
	- Mass spring damper can be analyzed in real-time with sliders
	- Tuning the system parameters and visualizing the results allows for a better understanding of the system behavior
"""

# ╔═╡ 05899b77-fc58-4556-ba9e-2969f3746ff4
Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/msd_airplace.png")

# ╔═╡ 327a1dc7-ab8b-477b-8dec-00bf381c76cf
msd_u0, msd_ps, msd_prob, msd_sys,  msd_bg, msd_tf_sym, msd_tf_func = let
	# Make Time Variable
	@variables t, α, ω
	# Make Bond Graph
	msd = BondGraph(t, :msd)
	# Add Bond Graph Elements
	add_I!(msd, :m)
	add_C!(msd, :k)
	add_R!(msd, :b)
	add_Se!(msd, :F)
	# Add 1-Junction
	add_1J!(msd, Dict(
		:m => false,
		:k => false,
		:b => false,
		:F => true
		), :J1)
	# Generate Model
	sys = generate_model(msd)
	sys = structural_simplify(sys)
	# Set Initial Equations	
	u0 = [
		msd[:m].p => 0.0,
		msd[:k].q => 0.0,
	]|>Dict
	ps = [
		msd[:m].I => 1.0,
		msd[:k].C => 1.0,
		msd[:b].R => 1.0,
		msd[:F].Se => 1.0
	]|>Dict
	tspan = (0.0,10.0)
	prob = ODEProblem(sys, u0, tspan, ps)
	# -------
	A, B, C, D, x⃗, u⃗, y⃗ = state_space(msd, sys)
	@variables s Fc(s) x(s)
	C = C[y⃗[msd[:k].f], :]
	D = D[y⃗[msd[:k].f], :]
	tf = ((C'*inv(s*I(size(A,1)).-A)*B.+D).|>simplify_fractions)[1]
	tf_func = build_function(tf, [s, msd[:m].I, msd[:k].C, msd[:b].R], expression = Val{false})
	u0, ps, prob, sys, msd, (s*x/Fc ~ tf), tf_func
end;

# ╔═╡ 3f09a83c-01e5-4932-b4b9-b34a0e4a951a
let
	@variables s Fc(s) ẋ(s)
	LaTeXString.(replace.(latexify([full_equations(msd_sys); msd_tf_sym]), "{\\_+}" => "_{+}"))
end

# ╔═╡ f9f57858-01c5-49b5-a718-a0af8f34eb3c
md"""
### Animations
- Equation driven animations
"""

# ╔═╡ 0ddd71bc-ea00-4cb0-838a-7b51f702ca6b
md"""
Render [check]: $(@bind render_animation CheckBox())
"""

# ╔═╡ 832be2af-d3e7-45d1-be8e-05a210c4173d
md"""
# 5. Traditional Approaches to Dynamic Systems
"""

# ╔═╡ bff336f2-ce8d-4653-b417-3d70f121232d
md"""
## Example 5.1: Linear Time Invariant (LTI) System Analysis
"""

# ╔═╡ cac617ec-48eb-49ae-83a1-8b68658170d0
md"""
!!! tip "Note on DC Motors"
	- DC Motors are a common way of creating motion in a mechatronic system. 
	- DC motors are simple to model yet provide a way predict the behavior of the system
	- Controlling a DC motor and maintaining a constant angular velocity allows for the system to maintain steady motion
	- One version of an idealized model for a DC Motor is provided.
"""

# ╔═╡ 09338c5f-26ed-447a-ba92-37c4437df35a
begin
	input(x, t) = [1.0, -0.25*(5.0<=t<=10.0)+0.25*(15.0<=t<=20.0)]
	dt = 0.05
	t = 0.0:dt:20.0
end;

# ╔═╡ ad53d7b6-4370-4367-b53d-34da2a72312e
motor_ss_dict, motor_bg = let 
	@variables t
    motor = BondGraph(t, :motor)
    # Add Elements
    add_Se!(motor, :ec)
    add_R!(motor, :Rw)
    add_Bond!(motor, :b3)
    add_Bond!(motor, :b4)
    add_C!(motor, :kτ)
	add_R!(motor, :R)
    add_Bond!(motor, :b6)
    add_I!(motor, :J)
    add_Se!(motor, :τd)
    # Add Gyrator
    add_GY!(motor, :b3, :b4, :T)
    # Add Junctions
    add_1J!(motor, Dict(
            :ec => true,
            :Rw => false,
            :b3 => false
            ), :J11)
    add_0J!(motor, Dict(
            :b4 => true,
        	:kτ => false,
            :b6 => false
            ), :J01)
    add_1J!(motor, Dict(
            :b6 => true,
            :J => false,
            :τd => true,
			:R => false
            ), :J12)
    # Generate Modelalg
    sys = generate_model(motor)
    sys = structural_simplify(sys)
    A, B, C, D, x⃗, u⃗, y⃗ = state_space(motor, sys);
	ss_dict = Dict(
		:A => A,
		:B => B,
		:C => C,
		:D => D,
		:x => x⃗, 
		:u => u⃗, 
		:y => y⃗
	)
	ss_dict, motor
end;

# ╔═╡ fd102b04-83f1-40db-a541-c010fd07602d
md"""
### Problem Parameters	
"""

# ╔═╡ bc8ba6de-1ead-4ff1-a4cc-74c085f9dfc9
md"""
!!! note "Problem"
	Explain how the problem parameters influence the following system responses:
	  1. Peaks in the amplitude ratio
	  2. Oscillations in the step response
	  3. Comment on system response from the Nyquist Plot
"""

# ╔═╡ 49c5a12e-a71a-441e-ab2a-91ee3e3a39f3
md"""
Rw = $(@bind Rwval PlutoUI.Slider(range(1.0,10.0, length = 101), default = 1.0)) [Ω]
T = $(@bind Tval PlutoUI.Slider(range(0.0,1.0, length = 101), default = 0.5)) [N*m/A]
m = $(@bind mval PlutoUI.Slider(range(5/2.2,10.0, length = 101), default = 5.0)) [lb]

Radius = $(@bind Radiusval PlutoUI.Slider(range(4.0,10.0, length = 101), default = 4.0)) [in]
ωn = $(@bind ωnval PlutoUI.Slider(range(-2,2, length = 101), default = 1.0)) [Hz]
R-Friction = $(@bind Rval PlutoUI.Slider(range(0.2,10.0, length = 101), default=0)) [-]
"""

# ╔═╡ 1c76f7f2-8113-47ec-a77c-e520937f9ea1
motor_ss, motor_tf, motor_ps = let
	p = Dict{Num, Float64}()
	@parameters m, ωₙ, R
	p[motor_bg[:Rw].R] = Rwval
	p[motor_bg[:T].r]  = Tval
	p[m]            = mval/2.2
	p[R]            = Radiusval*0.0254
	p[motor_bg[:J].I]  = p[m]*p[R]^2/2.0
	p[ωₙ]           = ωnval
	# p[motor_bg[:kτ].C] = 1/(10.0^kτval)
	p[motor_bg[:kτ].C] = 1/(p[motor_bg[:J].I]*(10^(ωnval)*2*π)^2)
	p[motor_bg[:R].R] = Rval
	A = Symbolics.value.(substitute.(motor_ss_dict[:A], (p,)))
	B = Symbolics.value.(substitute.(motor_ss_dict[:B], (p,)))
	C = [0 1/p[motor_bg[:J].I]]
	D = [0 0]
	motor_ss = minreal(ss(A, B, C, D))
	motor_tf = tf(motor_ss)
	motor_tf = minreal(motor_tf)
	motor_ss, motor_tf, p
end;

# ╔═╡ adedcd94-e5db-438b-a1ba-2375ef40faaa
let
	w  = 10.0 .^ range(-4, 4, length = 101)
	inputs = ["Voltage", "Disturbance Torque"]
	
	AR = [20.0 .* log10.(abs.(vcat(motor_tf[1,i].(w*im*2π)...))) for i in 1:size(motor_tf, 2)]
	PA = [angle.(vcat(motor_tf[1,i].(w*im/2π)...)).*180/π for i in 1:size(motor_tf, 2)]
	STEP = [step(motor_tf[1,i], 0.5) for i in 1:size(motor_tf, 2)]
	
	ar_p = Plot(Config())
	ar_d = [Config(x = w, 
					y = Vector(AR[i][:]),
					mode = "lines", 
					line = Config(color=[:red, :blue][i]), 
					name = inputs[i], 
					legendgroup = inputs[i], 
					xaxis = "x1", 
					yaxis = "y1"
					) for i in 1:size(motor_tf, 2)
					]
	
	pa_d = [Config(x = w, 
					y = Vector(PA[i][:]), 
					mode = "lines", 
					line = Config(color=[:red, :blue][i]), 
					name = inputs[i], 
					legendgroup = inputs[i], 
					xaxis = "x2", 
					yaxis = "y2", 
					showlegend=false
					) for i in 1:size(motor_tf, 2)
					]
	step_d = [Config(x = STEP[i].t, 
					 y = STEP[i].y,
					 line = Config(color=[:red, :blue][i]), 
					 name = inputs[i],
					 legendgroup = inputs[i],
					 xaxis = "x3", 
					 yaxis = "y3", 
					 showlegend=false
					)
					for i in 1:size(motor_tf, 2)]
	ar_p.data = [ar_d;pa_d;step_d]
	ar_p.layout.grid=Config(rows=1, columns=3, pattern="independent")
	ar_p.layout.xaxis1 = Config(
				type="log", 
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title = "Frequency [Hz]")
	ar_p.layout.yaxis1 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title = "Amplitude Ratio [dB]")
	ar_p.layout.xaxis2 = Config(
				type="log", 
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title="Frequency [Hz]")
	ar_p.layout.yaxis2 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title = "Phase Angle [°]")
	ar_p.layout.xaxis3 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title="Time [s]")
	ar_p.layout.yaxis3 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title = "Magnitude")
	ar_p.layout.legend = Config(
				orientation="h", 
				x = 0.33, 
				y = -0.3
			)
	ar_p.layout.annotations = [
			Config(
				text = "Amplitude Ratio",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.08,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			),
			Config(
				text = "Phase Angle",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.5,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			),
			Config(
				text = "Step Response",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.925,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			)
	]
	ar_p.layout.margin = Config(t=50)
	ar_p
end

# ╔═╡ 58527c5b-b1c3-417a-b8fe-4bafda16f948
let
	inputs = ["Voltage", "Disturbance Torque"]
	ω = exp10.(range(-5, 100, length = 1000))
	nyquist_data = similar([Config()],0)
	for i in eachindex(motor_tf.matrix)
		real_resp, imag_resp = nyquist(motor_tf[1,i], ω)[1:2]
		push!(nyquist_data, Config(
			x = real_resp, 
			y = imag_resp, 
			hovertext = "ω=".*string.(ω), 
			hoverinfo = "text", 
			mode = "scatter", 
			xaxis = "x1",
			yaxis = "y1",
			line = Config(color=[:red, :blue][i]), 
			name = inputs[i],
			legendgroup = inputs[i]
			)
		)
	end
	push!(nyquist_data,  Config(
			x = sin.(0:0.1:2π),
			y = cos.(0:0.1:2π),
			name = "Distrubance",
			mode = "scatter", 
			xaxis = "x1",
			yaxis = "y1",
			line = Config(color=:grey, dash = "dash"), 
		)
	)
	push!(nyquist_data, Config(
		x = [-1], 
		y = [0],
		mode = "scatter",
		name = "Disturbance",
		xaxis = "x1",
		yaxis = "y1",
		marker = Config(size = 10,symbol="x", color = :orange),
		line = Config(width = 0)
		)
	)
	
	rl_data = similar([Config()],0)
	A = Symbolics.value.(substitute.(motor_ss_dict[:A], (motor_ps,)))
	B = Symbolics.value.(substitute.(motor_ss_dict[:B], (motor_ps,)))
	C = zeros(size(A, 2))
	D = zeros(size(B, 2))
	x⃗ = motor_ss_dict[:x]
	C[x⃗[motor_bg[:kτ].q]] = 1.0
	sys = ss(A, B, C', 0)
	motor_tf = tf(sys)
	Z = tzeros(motor_tf[1,1])
	K = range(1e-6, 500, length = 100)
	roots, K = ControlSystems.getpoles(motor_tf[1,1], K)
	redata = real.(roots)
	imdata = imag.(roots)
	
	for i in 1:size(redata, 2)
		push!(rl_data, Config(
				x = redata[:, i],
				y = imdata[:, i],
				name= inputs[i],
				showlegend=false,
				legendgroup = inputs[i],
				hovertext = "k=".*string.(K), 
				hoverinfo = "text", 
				mode = "scatter", 
				xaxis = "x2",
				yaxis = "y2",
				line = Config(color=[:red, :blue][i]),
			)
		)
	end
	push!(rl_data, Config(
			x = real.(Z),
			y = imag.(Z),
			name = "Zeros",
			mode = "scatter",
			xaxis = "x2",
			yaxis = "y2",
			marker = Config(size = 10,symbol="x", color = :green),
			line = Config(width = 0)
		)
	)
	push!(rl_data, Config(
			x = redata[1, :],
			y = imdata[1, :],
			name = "Open-loop Poles",
			mode = "scatter",
			xaxis = "x2",
			yaxis = "y2",
			marker = Config(size = 10,symbol="x", color = :purple),
			line = Config(width = 0)
		)
	)
	p = Plot(Config())
	p.data = [nyquist_data;rl_data]
	p.layout.grid = Config(rows = 1, columns = 2, pattern = "independent")
	p.layout.xaxis1 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title = "ℛℯ|𝐺(ω)|")
	p.layout.yaxis1 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title = "ℐ𝓂|𝐺(ω)|")
	p.layout.xaxis2 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title="ℛℯ")
	p.layout.yaxis2 = Config(
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false,
				title = "ℐ𝓂")
	p.layout.annotations = [
			Config(
				text = "Nyquist Plot",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.18,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			),
			Config(
				text = "Root Locus Plot",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.825,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			)
		]
	p.layout.legend = Config(
				orientation="h", 
				x = 0.33, 
				y = -0.3
			)
	# p.layout.grid.rows = 1
	# p.layout.grid.columns = 2 
	# p.layout.grid.pattern = "independent"
	# p.layout.yaxis1.matches = "x1"
	# p.layout.yaxis1.scaleanchor = "x1"
	# p.layout.yaxis.scaleratio = 1
	# p.layout.xaxis.title = "Re|G(ω)|"
	# p.layout.yaxis.title = "Im|G(ω)|"
	p
end

# ╔═╡ 38c127ad-a802-4915-866c-f2b9f39b2633
# let
# 	A = Symbolics.value.(substitute.(motor_ss_dict[:A], (motor_ps,)))
# 	B = Symbolics.value.(substitute.(motor_ss_dict[:B], (motor_ps,)))
# 	C = zeros(size(A, 2))
# 	D = zeros(size(B, 2))
# 	x⃗ = motor_ss_dict[:x]
# 	C[x⃗[motor_bg[:kτ].q]] = 1.0
# 	sys = ss(A, B, C', 0)
# 	motor_tf = tf(sys)
# 	Z = tzeros(motor_tf[1,1])
# 	K = range(1e-6, 170, length = 1000)
# 	roots, K = ControlSystems.getpoles(motor_tf[1,1], K)
# 	redata = real.(roots)
# 	imdata = imag.(roots)
# 	inputs = ["Voltage", "Torque"]
# 	rl_data = []
# 	for i in 1:size(redata, 2)
# 		push!(rl_data, Config(
# 			x = redata[:, i],
# 			y = imdata[:, i],
# 			name= inputs[i],
# 			hovertext = "k=".*string.(K), 
# 			hoverinfo = "text", 
# 			mode = "lines", 
# 			line = Config(color=[:red, :blue][i]),
# 		))
# 	end
# 	push!(rl_data, Config(
# 			x = real.(Z),
# 			y = imag.(Z),
# 			name = "Zeros",
# 			mode = "scatter",
# 			marker = Config(size = 10,symbol="x", color = :green),
# 			line = Config(width = 0)
# 		)
# 	)
# 	push!(rl_data, Config(
# 			x = redata[1, :],
# 			y = imdata[1, :],
# 			name = "Open-loop Poles",
# 			mode = "scatter",
# 			marker = Config(size = 10,symbol="x", color = :purple),
# 			line = Config(width = 0)
# 	))
# 	p = Plot(rl_data)
# 	# p.layout.grid=Config(rows=1, columns=2, pattern="independent")
# 	p.layout.xaxis.title = "Re(roots)"
# 	p.layout.yaxis.title = "Im(roots)"
# 	p
# end

# ╔═╡ 392d57e3-86c7-43b1-918d-5ebede3ffe75
md"""
### Controller Design
"""

# ╔═╡ cb3f9e19-0ca0-41a3-b60a-c8a24543e05d
md"""
!!! note "Create a controller to main a constant angular velocity while the disturbance torque changes"
	1. Create and tune a Feedforward (FF) controller
	2. Create and tune a Feedback (FB) controller
	3. Create and tune a PID Controller
	4. Create and tune a LQR Controller
	5. Comment on the results from tuning each of the controllers
!!! warning "Try changing the problem parameters to test robustness of controllers"
"""

# ╔═╡ 59cada5a-72ef-4574-ab04-b4d5eb8f6b74
# ╠═╡ disabled = true
#=╠═╡
y_ff, y_fb, y_pid, y_lqr = let
	## -------- Feedback Controller -------
	C = ControlSystems.append(ss(tf([kfb_gain],[1, 0])), tf([1]))
	OL = motor_ss*C
	fb = ss(zeros(2,2),zeros(2, 1),zeros(2,2), [1, 0])
	cl_fb = minreal(feedback(OL, fb))
	fb_sim = Simulator(cl_fb, input)
	fb_sol = solve(fb_sim, zeros(3), (0.0, t[end]), Tsit5())
	y_fb = map(t->fb_sim.y(fb_sol(t), t)[1], t)
	## ------ Feedforward Controller -------
	kff = ss(tf([kff_gain], [1.0]))
	cl_ff = ss(motor_tf*diagm([kff_gain, 1.0]))
	ff_sim = Simulator(cl_ff, input)
	ff_sol = solve(ff_sim, zeros(4), (0.0, t[end]))
	y_ff = map(t->ff_sim.y(ff_sol(t), t)[1], t)
	## ------ PID Controller -------
	Gc = pid(kp = kp, ki = ki, kd = kd)|>minreal
	Gp = motor_tf[1, 1]
	Gd = motor_tf[1, 2]
	OL = append(Gc*Gp, Gd)|>ss
	comb = ss([0], [0 0], [0], [1 1])|>minreal
	OL = series(OL, comb)|>minreal
	CL = feedback(OL, ss([0], [0], [0; 0], [1;0]))|>minreal
	pid_sim = Simulator(CL, input)
	pid_sol = solve(pid_sim, zeros(3), (0.0, t[end]))
	y_pid = map(t->pid_sim.y(pid_sol(t), t)[1], t)
	## ---------- LQR Controller -------
	motor_aug = [1; ss(tf([1], [1, 0]))]* motor_ss[1, 1]
	R = float.(I(1))*0.01
	Q =[Q11 Q12 Q13;Q12 Q22 Q23;Q13 Q23 Q33]
	K_lqr = lqr(motor_aug, Q, R)
	P = ss(motor_ss.A, motor_ss.B, vcat(motor_ss.C, [0 1], [1 0]), vcat(motor_ss.D, [0 0], [0 0]))
	C = ss(K_lqr*ControlSystems.append(tf([1],[1, 0]), tf([1]), tf([1])))
	OL = P * ControlSystems.append(C, tf([1]))
	CL = feedback(OL, ss(I(3)), U1 = 1:3, U2=1:3)
	cl_lqr = CL[1, 1:3:4]
	lqr_sim = Simulator(cl_lqr, input)
	lqr_sol = solve(lqr_sim, [0.0, 0.0, 0.0], (0.0, t[end]))
	y_lqr = map(t->lqr_sim.y(lqr_sol(t), t)[1], t)
	y_ff, y_fb, y_pid, y_lqr
end;
  ╠═╡ =#

# ╔═╡ 433cf2d5-465f-45cc-a16d-cab455fb03fa
# ╠═╡ disabled = true
#=╠═╡
let
	p = Plot(Config())
	
	labels = ["Feedforward" "Feedback" "LQR" "PID"]
	data = [y_ff, y_fb, y_lqr, y_pid]
	map(i->push!(p.data, Config(
		x=t,
		y=data[i], 
		name = labels[i],
		mode = "lines", 
		line = Config(color=PlotlyLight.Defaults.layout.x.template.layout.colorway[i])
	)), 1:size(data,1))
	push!(p.data, Config(
		x = t,
		y = ones(length(t)), 
		name = "ω-setpoint"
	))
	push!(p.data, Config(
		x = t, 
		y = getindex.(input.(0.0, t), 2),
		name = "Disturbance Torque"
	))
	p.layout.xaxis.title = "Time[s]"
	p.layout.yaxis.title = "Angular Velocity [rad/s]"
	p.layout.annotations = [
			Config(
				text = "Amplitude Ratio",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.5,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			)
		]
	# p.layout.margin.t = 50
	p
end
  ╠═╡ =#

# ╔═╡ e90c7cfe-88c0-4a2e-adb4-1f09e028de30
md"""
## Example 5.2: Nonlinear System Analysis
"""

# ╔═╡ 21a3f32a-b66a-4fbc-9358-958bc5960611
md"""
!!! note "Task"
	The following circuit has a non-linear relationship for the resistor. Perform the following:
	1. Derive the state equations
	2. Plot the trajecory in phase space and vary initial conditions 
	3. Plot a cross-section of the phase-space and vary cross section and some parameters
	4. Comment on the characteristics of the system
"""

# ╔═╡ 8fb74ff6-20d2-4852-9f7e-a138e781206b
md"""
### State Equations
"""

# ╔═╡ b4d99c41-0327-45ad-88fe-2e259ce4b8e5
chua_bg, chua_sys, chua_prob, chua_p, chua_u0, chua_states = let
	@variables t
	chua = BondGraph(t, :chua)
	# Add Nonlinear element
	@parameters Ga Gb E
	Φr(e, f, t, p) = p[2] * e + 1 / 2 * (p[1] - p[2]) * (abs(e + p[3]) - abs(e - p[3]))
	add_R!(chua, :f => Φr, [Ga, Gb, E], :Gn)
	# Add Linear Elements
	add_R!(chua, :G)
	add_R!(chua, :R)
	add_C!(chua, :C1)
	add_C!(chua, :C2)
	add_I!(chua, :L)
	# Add Bonds
	add_Bond!(chua, :b2)
	add_Bond!(chua, :b3)
	add_Bond!(chua, :b5)
	add_Bond!(chua, :b8)
	# Add Junctions
	add_1J!(chua, Dict(
  		:C2 => false,
  		:b2 => false
  		), :J11)
	add_1J!(chua, Dict(
  		:G => false,
  		:b3 => false
  		), :J12)
	add_0J!(chua, Dict(
  		:b2 => true,
  		:b3 => true,
	  	:b5 => false
  		), :J01)
	add_1J!(chua, Dict(
  		:b5 => true,
		:L  => false,
  		:R  => false,
  		:b8 => false
		), :J13)
	add_0J!(chua, Dict(
  		:b8 => true,
		:C1 => false,
  		:Gn => false
  		), :J02)
	sys = generate_model(chua)
	sys = structural_simplify(sys)
	####-----------------------
		p = [
  		chua[:R].R => 0.5845,
  		chua[:G].R => 1/3.733,
  		chua[:C1].C => 1.0,
  		chua[:C2].C => -44.5,
  		chua[:L].I => 0.4448,
  		chua[:Gn].E => 1.0,
  		chua[:Gn].Ga => -2.0,
  		chua[:Gn].Gb => -0.895
		] |> Dict
	## Set Initial Conditions
	u0 = [
  		chua[:C1].q => -5.0 * p[chua[:C1].C],
  		chua[:C2].q => -17.2098,
  		chua[:L].p =>  0.5 * p[chua[:L].I],
		] |> Dict
	## Set Time Span
	tspan = (0.0, 1000.0)
	## Make and Solve Problem
	prob = ODAEProblem(sys, u0, tspan, p)
	## Get the system States for the ODAEProblem
	state = ModelingToolkit.get_or_construct_tearing_state(sys)
    sts = state.fullvars
	sts = getindex.(getfield.(sts[ModelingToolkit.isdifferential.(sts)], :arguments),1)
	# sts = collect(states(sys))
	## -------------------------
	chua, sys, prob, p, u0, sts
end;

# ╔═╡ bbf58762-06a5-492c-8045-f619464d3612
let
	LaTeXString.(replace.(latexify(full_equations(BondGraphs.remove_algebraic(chua_bg, chua_sys)[1])), "{\\_+}" => "_{+}"))
end

# ╔═╡ b1508c1f-a38e-4572-b1f5-d9e006dbd8d5
md"""
### Trajectory Plotting
"""

# ╔═╡ d2c9241c-c284-4b8c-b31b-3120f6595354
md"""
V₁ Initial = $(@bind v1_init Slider(range(-10,10, length = 101), default = 0.0, show_value = true)) [V]
"""

# ╔═╡ f33f326d-2e4a-4ea0-a0c3-5dfcec9e368e
# let 
# 	chua_u0[chua_bg[:C1].q] = v1_init
# 	prob = remake(chua_prob, u0 = ModelingToolkit.varmap_to_vars(chua_u0, chua_states))
# 	sol = solve(prob, Tsit5())
# 	plot(sol, vars = (chua_bg[:C1].e, chua_bg[:C2].e, chua_bg[:L].f), opacity = 1, xlabel = "V₁", ylabel = "V₂", zlabel = "I₃", label = "", size = (500, 500))
# end

# ╔═╡ dd61ae6e-3adb-49df-bacd-40971356170c
let
	chua_u0[chua_bg[:C1].q] = v1_init
	prob = remake(chua_prob, u0 = ModelingToolkit.varmap_to_vars(chua_u0, chua_states))
	sol = solve(prob, Tsit5(), saveat=0.25)
	data = Config(x = sol[chua_bg[:C1].e], y = sol[chua_bg[:C2].e], z = sol[chua_bg[:L].f], type = "scatter3d", mode = "lines")
	p = Plot(data)
	p.data[].line.width = 0.5
	p.layout.margin.t = 0
	p.layout.margin.b = 0
	p.layout.scene.xaxis.title.text="V₁"
	p.layout.scene.yaxis.title.text="V₂"
	p.layout.scene.zaxis.title.text="I₃"
	p
end

# ╔═╡ 1ed90a5e-a795-4f53-8c4c-c2c3c0bdae2d
cds_sys, cds_states, cds = let
sys = generate_model(chua_bg)
sys = structural_simplify(sys)
sys_new, obs_eqn = BondGraphs.remove_algebraic(chua_bg, sys)
sys_new = extend(sys_new, ODESystem([obs_eqn;observed(sys)], name = :obs))
sys_new = structural_simplify(sys_new)
# Set Time Span
tspan = (0.0, 1000.0)
prob = ODEProblem(sys_new, chua_u0, tspan, chua_p, jac = true)
cds = ContinuousDynamicalSystem(prob)
	state = ModelingToolkit.get_or_construct_tearing_state(sys)
	sts = state.fullvars
	sts = getindex.(getfield.(sts[ModelingToolkit.isdifferential.(sts)], :arguments),1)
sys_new, sts, cds
end;

# ╔═╡ 914956d2-f31c-456a-8f97-e5007d88a463
md"""
### Cross - Section for V₁ and varying C₂
"""

# ╔═╡ a2f4dc21-aff8-4a57-9e09-25be9b91db1f
md"""
C₂ = $(@bind p1 Slider(range(-200, -39.95, length = 101), default = -100, show_value = true))
V₁ = $(@bind v1 Slider(range(-1.5, 1.5, length = 101), default = 1.5, show_value = true))
"""

# ╔═╡ 591bec61-3234-460f-adf0-578db0852265
md"""
!!! warning "Note on Behavior of the System"
	For some parameters, the system will exhibit a periodic orbit. A periodic orbit is characterized by near solid lines of points in the cross section. One example is for $C_2$ = -39.95 and $V_1$ = 1.5
"""

# ╔═╡ ae8384e6-673b-4e0e-8051-843b3cadc218
let
	cds.p[indexin([chua_bg[:C2].C], ModelingToolkit.parameters(cds_sys))[1]] = p1
	# scat = plot()
	v1_index = indexin([chua_bg[:C1].q], cds_states)[1]
	u0s = [
		[-5.0, -17.2098, 0.2224],
		[-3.0, -17.2098, 0.2224],
		[-1.0, -17.2098, 0.2224],
		[ 1.0, -17.2098, 0.2224],
		[ 3.0, -17.2098, 0.2224],
		[ 5.0, -17.2098, 0.2224]
	]
	datas = similar([Config()], length(u0s))
	idxs = eachindex(datas)
	for (u0, idx) in zip(u0s, idxs)
		psos = ChaosTools.poincaresos(cds, (v1_index, v1), 10000.0, u0 = u0)
		datas[idx] = Config(
			x = psos[:,2]./(-95.68), 
			y = psos[:,3]./0.4448,
			mode = "markers", 
			type = "scatter",
			marker = Config(size = 4),
			name  = "V₁initial = "*string(u0[1])
		)
	end
	p = Plot(datas)
	p.layout.xaxis.title = "V₂"
	p.layout.yaxis.title = "I₃"
	p.layout.title = "Cross-Section at V₁ =" *string(v1)*"V"
	p
end

# ╔═╡ 7b9e6197-72e1-4902-a146-0328d49788ce
md"""
# 6. Advanced Dynamic System Approaches
"""

# ╔═╡ 5e231fcd-ac2a-4c68-a4ee-1e1e958a6ae1
md"""
!!! tip "Advanced Dynamic Systems Modeling"
	1. Data is easy and cheap to get for experiments
	2. Data-focused techinques require more familiarity with how to program and develop better programs
"""

# ╔═╡ dcf30937-c327-4f5f-af11-f5f4c0e5e2a7
md"""
## Problem Introduction
"""

# ╔═╡ 9123967c-326a-4aa7-a055-865436fe2f49
md"""
!!! tip "Design Problem"
	- You are part of an innovative car company seeking to create a better car. 
	- You are going to be modeling to passenger comfort using a quarter car model
	- You've colllected data on measuring the mass of the car, and run tests measuring the rider displacement for different inputs.
!!! note "Task"
	1. Ensure your design does not resonant for a range of frequencies. The production facility produces car bodys with variations in mass
	2. The model becomes costly to compute for each wheel in a car. Find a faster way to compute the response
	3. Some parameters in the model are challenging to physically measure. Find the correct parameter by fitting model response to data.
"""

# ╔═╡ 548d9407-ffb8-4dde-a84d-9090c16b2419
car_bg, car_sys = let
	@variables t
	bg = BondGraph(t, :car)
	@parameters α ω
	## ----- Mechanical Components
	add_Sf!(bg, :vin)
	add_C!(bg, :kt)
	add_I!(bg, :mus)
	add_I!(bg, :ms)
	add_C!(bg, :ks)
	add_R!(bg, :bs)
	## ----- Electrical Components
	add_R!(bg, :R)
	add_I!(bg, :L)
	add_Se!(bg,  :Volt)
	## ----- Bonds
	for i in [3,5,7, 10, 11]
		add_Bond!(bg, Symbol("b"*string(i)))
	end
	## ----- Gyrator
	add_GY!(bg, :b10, :b11, :GY)
	# Add Junctions
	add_0J!(bg, Dict(
		:vin => true,
		:kt => false,
		:b3 => false
	), :j01)
	add_1J!(bg, Dict(
		:b3 => true,
		:mus => false,
		:b5 => false
	), :j11)
	add_0J!(bg, Dict(
		:b5 => true,
		:b7 => false,
		:ms => false
	), :j02)
	add_1J!(bg, Dict(
		:b7 => true,
		:bs => false,
		:ks => false,
		:b10 => false
	), :j12)
	add_1J!(bg, Dict(
		:b11 => true,
		:R => false,
		:L => false,
		:Volt => false
	), :j13)
	#
	sys = generate_model(bg)
	sys = structural_simplify(sys)
	new_sys, obs = BondGraphs.remove_algebraic(bg, sys)
	sys = extend(new_sys, ODESystem([obs;observed(sys)], sys.iv, name = :model))
	sys = structural_simplify(sys)
	bg, sys
		end;

# ╔═╡ db62accd-623e-41b4-aa1c-347ddfa1335c
let
	LaTeXString.(replace.(latexify(equations(car_sys)), "{\\_+}" => "_{+}"))
end

# ╔═╡ 47a83bd1-8f2f-4c3e-94c9-d899769b1ae9
md"""
## Example 6.1: Uncertainity in Measurements
"""

# ╔═╡ 6d187607-71a3-4524-96f9-73fd6dd98c46
md"""
!!! note "Task"
	1. Determine what response the passenenger will observe for a mean and standard deviation of the mass. 
	2. Comment on the differences between error propogation techinques
"""

# ╔═╡ 3df3f656-0737-4606-84d9-db214d44bf44
ex7_sys,particles = let
	eqs = full_equations(car_sys)
	@parameters α ω
	@variables t
	ps = ModelingToolkit.parameters(car_sys)
	popat!(ps, indexin([car_bg[:vin].Sf], ps)[1])
	sub_eqs = ModelingToolkit.simplify.(substitute.(eqs, (Dict(car_bg[:vin].Sf => α*sin(ω*t)),)))
	@named sys = ODESystem(sub_eqs, car_sys.iv, states(car_sys), [ps; [α, ω]], observed = observed(car_sys))
	sys = structural_simplify(sys)
	sys, StaticParticles(100)
end;

# ╔═╡ 49f0d0ee-703d-4995-b51e-946822415e12
md"""
Avereage Weight[kg] = $(@bind μ Slider(range(10, 30, length = 101), show_value = true))

Standard Deviation[kg] = $(@bind σ Slider(range(1, 5, length = 101), show_value = true))
"""

# ╔═╡ 45c057fc-473e-4864-9ade-47f4a0e0d154
md"""
## Example 6.2: Surrogate Modeling (Digital Twins)
"""

# ╔═╡ 8fe705ed-4085-411c-bbfc-ac99e47ea57d
md"""
!!! note "Task"
	- Solving ODE is costly to evaluate for a large systems.
	- Scaling the quarter car model from the previous examples would be possible but large systems of equations would need to be solved.
	- Surrogate modeling or digital twins allow for portions of the system to have their dynamics approximated by easy to evaluate approximations.
	- For the car system: Find a surrogate relating the disturbance velocity to the unsprung mass velocity
"""

# ╔═╡ 66a2687c-af4d-4155-a332-8e9faeeae4b5
Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/full_car.png")

# ╔═╡ 817312ea-13a1-4947-ad65-53b9166879dd
md"""
## Example 6.3: Parameter Estimation
"""

# ╔═╡ 40b6a34d-d693-4dc1-a07d-8aeadb16e6b3
md"""
!!! note "Task"
	1. Forward  Problem in Modeling: Provided initial conditions and parameters, find the output
	2. Inverse Problem in Modeling: Provided inputs and outputs, find the most likely parameters
	3. Find the possible model parameters that match the data observed
	4. Comment on how measurement noise influences the accuracy of the surrogate model

Input: Fixed Amplitude Disturbance Velocity with frequency[Hz] = $(@bind diffeqparamfreq confirm(Slider(range(1, 10, length = 11), show_value = true)))

Measurement Noise Amplitude: $(@bind meas_noise confirm(Slider(range(0.001, 1.0, length = 11), show_value = true)))
"""

# ╔═╡ 6001d7f1-12f4-4c6c-9fa8-b8a6a8c6251c
md"""
# 7. Next Steps
  1. Add remainder of pedagological content to complete this and other I³-LIB books.
  2. Use metacognitive theory and interactive tools to learn where students are struggling and provide feedback. 
  3. Include a drag and drop interaction (for example logic circuit below for Mechatronics I³-LIB).
  4. Create cyber-physical interactions (for example Smart Manufacturing I³-LIB)
"""

# ╔═╡ a1e33edc-ca6c-45ae-828b-312d6e0542d1
md"""
# 8. Alpha Stage: Drag and Drop
"""

# ╔═╡ e1126ec3-b5e5-4981-9438-ac7a2e1b6f38
HTML(raw"""
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Draggable - Snap to element or grid</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <style>
  <!--.draggable { width: 50px; height: 50px; padding: 5px; float: left; margin: 0 10px 10px 0; font-size: .9em; }-->
  .ui-widget-header p, .ui-widget-content p { margin: 0; }
  #snaptarget { height: 300px; }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
  <script>
  $( function() {
    $("#R").draggable({snap: true});
    $("#I").draggable({snap: true});
    $("#C").draggable({snap: true});
    $("#0").draggable({snap: true});
    $("#1").draggable({snap: true});
    $("#TF").draggable({snap: true});
    $("#GY").draggable({snap: true});
    $("#Se").draggable({snap: true});
    $("#Sf").draggable({snap: true});
  } );
  </script>
</head>
<body>
 
<div id="snaptarget" class="ui-widget-header">
  <p>Bond Graph Build Area</p>
</div>
 
<br style="clear:both">
 
<div id="R" class="draggable ui-widget-content">
  <p>R</p>
</div>
 
<div id="I" class="draggable ui-widget-content">
  <p>I</p>
</div>
 
<div id="C" class="draggable ui-widget-content">
  <p>C</p>
</div>

<div id="1" class="draggable ui-widget-content">
  <p>1</p>
</div>

<div id="0" class="draggable ui-widget-content">
  <p>0</p>
</div>

<div id="TF" class="draggable ui-widget-content">
  <p>TF</p>
</div>

<div id="GY" class="draggable ui-widget-content">
  <p>GY</p>
</div>

<div id="Se" class="draggable ui-widget-content">
  <p>Se</p>
</div>

<div id="Sf" class="draggable ui-widget-content">
  <p>Sf</p>
</div>
</body>
""")

# ╔═╡ 72416995-ac8e-43e2-80d2-1ca84cf11da7
Resource("https://raw.githubusercontent.com/cfarm6/BondGraphPictures/main/i3lib.mp4#t=22,103")

# ╔═╡ 636d0760-4d33-4e28-99f1-040a0748c799
md"""
# 9. Cyber - Physical Interaction Example (Arm Robot)
"""

# ╔═╡ a1b21817-ea48-4002-a80f-1960e5d12d54
let
	if (TOC)
	WidthOverDocs(true, 20)
else 
	WidthOverDocs(true, 0)
end
end

# ╔═╡ a21b4b2a-96f2-4168-96ca-0666055975c7
# html"""
# <style>
# pluto-output h1 {border-bottom: 4px solid  hsla(216, 77%, 17%, 1.0)}
# pluto-output h2 {border-bottom: 3px dotted hsla(216, 77%, 17%, 1.0)}
# pluto-output h3 {border-bottom: 2px dotted hsla(216, 77%, 17%, 1.0)}
# pluto-output h5 {text-align: center}
# pluto-output p {font-size:26px}
# pluto-output li {font-size:26px}
# pluto-output table > tbody td {font-size: 0.9em;}
# pluto-output li {font-size:26px}
#       caption {
#         background: #fff;
# 		font-size: 1.5em;
#         caption-side: top;
#       }
# </style>
# """

# ╔═╡ a81168cd-eb9c-47d9-bdc3-bd2a2566a273
RGBA(0.0, 1.0, 2.0, 0.1)|>typeof|>fieldnames

# ╔═╡ f7af0b08-66f1-4b3f-aca5-2291f8d18306
HTML("""<head>
	<!-- Load plotly.js into the DOM -->
	<script src='//cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML'></script>
	<script src='https://cdn.plot.ly/plotly-2.9.0.min.js'></script>
</head>""")

# ╔═╡ 3844323c-8579-409c-a7bd-5b423b8c610b
if TOC
	TableOfContents()
end

# ╔═╡ 42043350-3ffd-4186-9bc1-382fd88d080c
rgba_string(color) = "rgba($(color.r), $(color.g), $(color.b), $(color.alpha))"

# ╔═╡ 9ba77432-a5e3-4f79-94da-f034a8976aff
let
	@parameters α ω
	u0 = Dict{Num, Any}([
		car_bg[:kt].q  => 0.0,
		car_bg[:mus].p => 0.0, 
		car_bg[:ms].p  => 0.0,
		car_bg[:ks].q  => 0.0,
		car_bg[:L].p   => 0.0
	])
	p = Dict{Num, Any}([
		car_bg[:kt].C  => 1/100.0,
		car_bg[:ks].C  => 1/100.0,
		car_bg[:ms].I  => measurement(μ, σ),
		car_bg[:mus].I => 100.0,
		car_bg[:bs].R  => 5.0,
		car_bg[:Volt].Se => 0.0,
		car_bg[:GY].r  => 0.9,
		car_bg[:L].I   => 1e-3,
		car_bg[:R].R   => 5.0,
		α => 1.0,
		ω => 2*π*10
	])
	tspan = (0.0, 20.0)
	prob = ODEProblem(ex7_sys, u0, tspan, p)
	sol = solve(prob, Tsit5(), saveat = 0.5)
	st = states(car_sys)
	measurement_data = similar([Config()], length(st))
		data_colors = [
				RGBA(1.0, 0, 0, 1.0), 
				RGBA(0, 0, 1.0, 1.0), 
				RGBA(0, 0.5, 0.4, 1.0), 
				RGBA(0.5, 0, 0.75, 1.0), 
				RGBA(0.5, 0.75, 0, 1.0)
			]
	for i in eachindex(st)
		measurement_data[i] = Config(
			x = sol.t, 
			y = Measurements.value.(sol[st[i]]),
			name = string(st[i]),
			legendgroup = string(st[i]),
			showlegend = false,
			error_y = Config(
				type = "data",
				array = Measurements.uncertainty.(sol[st[i]])
			),
			xaxis = "x1",
			yaxis = "y1",
			mode = "lines", 
			line = Config(color=rgba_string(data_colors[i])), 
		)
	end
	###############3
	p = [
		car_bg[:kt].C  => 1/100.0,
		car_bg[:ks].C  => 1/100.0,
		car_bg[:ms].I  => μ,
		car_bg[:mus].I => 100.0,
		car_bg[:bs].R  => 5.0,
		car_bg[:Volt].Se => 0.0,
		car_bg[:GY].r  => 0.9,
		car_bg[:L].I   => 1e-3,
		car_bg[:R].R   => 5.0,
		α => 1.0,
		ω => 2*π*10, # 4π±1π
	]|>Dict
	prob = ODEProblem(ex7_sys, u0, tspan, p)
 	# # ---------------------
	function prob_func(prob, i, repeat)
		p[car_bg[:ms].I] = μ+σ*randn()
		prob.p .= ModelingToolkit.varmap_to_vars(p, ModelingToolkit.parameters(ex7_sys))
		prob
	end
	eprob = EnsembleProblem(prob, prob_func = prob_func)
	sim = solve(eprob, Tsit5(), EnsembleThreads(), trajectories = 100, saveat = 0.5)
	sol = EnsembleSummary(sim, quantiles=[0.025, 0.975])
	mc_data = similar([Config()], length(st))
	error = similar([Config()], length(st))

	error_colors = [
				RGBA(1.0, 0, 0, 0.2), 
				RGBA(0, 0, 1.0, 0.2), 
				RGBA(0, 1.0, 0, 0.2), 
				RGBA(0.5, 0, 0.75, 0.2), 
				RGBA(0.5, 0.75, 0, 0.2)
			]
	for i in eachindex(st)
		mc_data[i] = Config(
			x = sol.t, 
			y =	sol.u[i, :],
			name = string(st[i]),
			xaxis = "x2",
			yaxis = "y2",
			legendgroup = string(st[i]),
			mode = "lines", 
			line = Config(color=rgba_string(data_colors[i])), 
		)
		error[i] = Config(
			x = [sol.t;reverse(sol.t)], 
			y = [sol.u[i, :]+sqrt.(sol.v[i, :]);reverse(sol.u[i, :]-sqrt.(sol.v[i, :]))],
			fill= "tozerox",
			xaxis = "x2",
			yaxis = "y2",
			legendgroup = string(st[i]),
			name = string(st[i]),
			fillcolor = rgba_string(error_colors[i]),
			line = Config(color = "transparent"),
			showlegend = false
		)
	end
	p = Plot([measurement_data;mc_data;error])
	p.layout.grid = Config(rows = 1, columns = 2, pattern = "independent")
	p.layout.xaxis1.title = "Time[s]"
	p.layout.yaxis1.title = "Amplitude"
	p.layout.xaxis2.title = "Time[s]"
	p.layout.yaxis2.title = "Amplitude"
	p.layout.annotation = [
			Config(
				text = "Linear Error Propogation",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.08,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			),
			Config(
				text = "Monte Carlo Analysis",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.08,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			),
	]
	p
end

# ╔═╡ 7905f3bd-7c91-448d-952e-06e18c5761ae
begin
	PlotlyLight.template!("gridon")
	# PlotlyLight.Defaults.config.x.responsive = true
	PlotlyLight.Defaults.layout[].template.layout.xaxis.mirror = true
	PlotlyLight.Defaults.layout[].template.layout.xaxis.ticks="outside"
	PlotlyLight.Defaults.layout[].template.layout.xaxis.showline=true
	PlotlyLight.Defaults.layout[].template.layout.xaxis.zeroline=false
	PlotlyLight.Defaults.layout[].template.layout.yaxis.mirror = true
	PlotlyLight.Defaults.layout[].template.layout.yaxis.ticks="outside"
	PlotlyLight.Defaults.layout[].template.layout.yaxis.showline=true
	PlotlyLight.Defaults.layout[].template.layout.yaxis.zeroline=false
	PlotlyLight.Defaults.layout[].template.layout.margin.t=50
end

# ╔═╡ 1a241b91-9da2-4f89-85de-1e8e8f3b8dc4
begin
	struct TwoRow{A, B}
		top::A
		bottom::B
	end
	function Base.show(io, mime::MIME"text/html", tc::TwoRow)
		# write(io,
		# 	"""
		# 	<div style="display: flex;">
		# 		<div style="flex: 100%;">
		# 	""")
		show(io, mime, tc.top)
		write(io, """<br>""")
		# write(io,
		# 	"""
		# 		</div>
		# 		<div style="flex: 100%;">
		# 	""")
		show(io, mime, tc.bottom)
		# write(io,
		# 	"""
		# 		</div>
		# 	</div>
		# """)
	end
end

# ╔═╡ 5ba902c1-f88e-4881-a204-60ce5fd7d80b
begin
	struct TwoColumn{A, B}
		left::A
		right::B
	end
	function Base.show(io, mime::MIME"text/html", tc::TwoColumn)
		write(io,
			"""
			<div style="display: flex;">
				<div style="flex: 50%;">
			""")
		show(io, mime, tc.left)
		write(io,
			"""
				</div>
				<div style="flex: 50%;">
			""")
		show(io, mime, tc.right)
		write(io,
			"""
				</div>
			</div>
		""")
	end
	struct FlexTwoColumn{A, C, Pa, Pc}
		left::A
		right::C
		per_a::Pa
		per_c::Pc
	end
	function Base.show(io, mime::MIME"text/html", tc::FlexTwoColumn)
		write(io,
			"""
			<div style="display: flex;">
				<div style="flex: $(tc.per_a)%;">
			""")
		show(io, mime, tc.left)
		write(io,
			"""
				</div>
				<div style="flex: $(tc.per_c)%;">
			""")
		show(io, mime, tc.right)
	end
	struct ThreeColumn{A, B, C}
		left::A
		middle::B
		right::C
	end
	function Base.show(io, mime::MIME"text/html", tc::ThreeColumn)
		write(io,
			"""
			<div style="display: flex;">
				<div style="flex: 33%;">
			""")
		show(io, mime, tc.left)
		write(io,
			"""
				</div>
				<div style="flex: 33%;">
			""")
		show(io, mime, tc.middle)
		write(io,
			"""
				</div>
				<div style="flex: 33%;">
			""")
		show(io, mime, tc.right)
		write(io,
			"""
				</div>
			</div>
		""")
	end
	struct FlexThreeColumn{A, B, C, Pa, Pb, Pc}
		left::A
		middle::B
		right::C
		per_a::Pa
		per_b::Pb
		per_c::Pc
	end
	function Base.show(io, mime::MIME"text/html", tc::FlexThreeColumn)
		write(io,
			"""
			<div style="display: flex;">
				<div style="flex: $(tc.per_a)%;">
			""")
		show(io, mime, tc.left)
		write(io,
			"""
				</div>
				<div style="flex: $(tc.per_b)%;">
			""")
		show(io, mime, tc.middle)
		write(io,
			"""
				</div>
				<div style="flex: $(tc.per_c)%;">
			""")
		show(io, mime, tc.right)
		write(io,
			"""
				</div>
			</div>
		""")
	end
end

# ╔═╡ 707337fe-ce18-4a62-9ba5-96d951b001fd
TwoColumn(md"""
1. With the advent of Industry 4.0 (IoT, 5G, autonomous systems, etc.), there is a great need to teach engineering students intgrated modeling appraches that involve multi-energy domains
1. Bond Graphs provide a compact graphical method for representing multi-domain systems in a unified modeling diagram
1. Following a set of rules, the governing equations of the system can be dervied allowing for overall design, analysis, and controller design. 
""", Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/doe_car_hybrid.jpg"))

# ╔═╡ f50f1b34-edf5-4372-85c6-e5757af05f72
TwoColumn(Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/active_quarter_car.jpg"), Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/quarter_car_block.png"))

# ╔═╡ 7ab72fc2-34f8-45ab-8cf7-ce87ef576891
ThreeColumn(x_q_slider, y_q_slider, z_q_slider)

# ╔═╡ 5cd2a593-256d-4d2f-af31-fb46ffa2a6f2
ThreeColumn(HTML("x₀ = "*string(x_q)),HTML("y₀ = "*string(y_q)),HTML("z₀ = "*string(z_q)))

# ╔═╡ 51eb45c5-b97b-4b9a-895a-11f2497a43a0
ThreeColumn(xy_r_slider, yz_r_slider, zx_r_slider)

# ╔═╡ b0417a15-e141-4230-93ec-e0a2caac8d4c
ThreeColumn(HTML("r_xy = "*string(xy_r)),HTML("r_yz = "*string(yz_r)),HTML("r_zx = "*string(zx_r)))

# ╔═╡ 8508c5b8-5846-4707-989b-d90f68b21414
ThreeColumn(x_k_slider, y_k_slider, z_k_slider)

# ╔═╡ 1b9ed3d7-435a-40e8-a2c4-14d8d1bfacf3
ThreeColumn(HTML("k_x = "*string(x_k)),HTML("k_y = "*string(y_k)),HTML("k_z = "*string(z_k)))

# ╔═╡ 3f4bc834-5f99-40e3-8f80-35b934881dd7
ThreeColumn(( @bind m_val Slider(1:10, default = 5)), (@bind k_val Slider(1:10, default = 9)), (@bind b_val Slider(0:10, default = 8)))

# ╔═╡ 3e43d179-ec6a-42dc-b25f-e651ccfca429
let
	msd_ps[msd_bg[:m].I] = m_val
	msd_ps[msd_bg[:k].C] = 1/k_val
	msd_ps[msd_bg[:b].R] = b_val
	prob = remake(msd_prob, u0 = ModelingToolkit.varmap_to_vars(msd_u0, states(msd_sys)), p = ModelingToolkit.varmap_to_vars(msd_ps, ModelingToolkit.parameters(msd_sys)),)
	sol = solve(prob, Tsit5(), saveat = 0.1)
	disp_data = Config(
		x = sol.t, 
		y = sol[msd_bg[:k].q], 
		name = " a",
		legendgroup = " a",
		xaxis = "x1", 
		yaxis = "y1",
		mode = "lines", 
		line = Config(color=:red), 
	)
	
	ωs =  10 .^(-3:0.01:3)
	res = map(ω->msd_tf_func([2*π*ω*im, m_val, 1/k_val, b_val]), ωs)
	AR = 20.0*log10.(abs.(res))
	ar_data = Config(
		x = ωs./2π, 
		y = AR, 
		name=" a",
		legendgroup = " a",
		title = "Amplitude Ratio",
		xaxis = "x2",
		yaxis = "y2",
		mode = "lines", 
		line = Config(color=:red), 
	)
	p = Plot(Config())
	p.data = [disp_data; ar_data]
	p.layout = Config(
		grid=Config(rows=1, columns=2, pattern="independent"),
		xaxis1 = Config(
				title="Time [s]",
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false
				),
		yaxis1 = Config(
				title="Displacement [m]",
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false
				),
		xaxis2 = Config(
				type="log", 
				title="Frequency [Hz]",
		 		mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false
				),
		yaxis2 = Config(
				title="Amplitude Ratio [dB]",
				mirror = true,
				ticks="outside",
				showline=true,
				zeroline=false
			),
		showlegend = false,
		annotations = [
			Config(
				text = "Displacement",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.185,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			),
			Config(
				text = "Amplitude Ratio",
				font = Config(size = 20),
				showarrow=false,
				align = "center",
				x = 0.825,
				xref = "paper",
				y = 1.2,
				yref = "paper",
			)
		],
		margin = Config(t=50)
		)
	p
end

# ╔═╡ 8cb4d629-489a-461a-b9ca-3492b434f15f
# ╠═╡ disabled = true
#=╠═╡
let
	if render_animation
	# Timestep size
	dt = 1e-1
	# Frame Dimensions
	frame_width = 500
	frame_height = 500
	# Mass Size
	box_half_width = 40
	box_half_height = 40
	# Spring Size
	spring_length = box_half_width/2
	spring_height = box_half_height/2
	spring_segment = spring_length/10
	# Damper Length
	damper_length = box_half_width/2
	damper_height = box_half_height/1.5
	# Spacing
	space = 10
	# Set parameters from sliders
	msd_ps[msd_bg[:m].I] = m_val
	msd_ps[msd_bg[:k].C] = 1/k_val
	msd_ps[msd_bg[:b].R] = b_val
	# Remake Problem
	prob = remake(msd_prob, u0 = ModelingToolkit.varmap_to_vars(msd_u0, states(msd_sys)), p = ModelingToolkit.varmap_to_vars(msd_ps, ModelingToolkit.parameters(msd_sys)))
	# Solve problem with timestep = dt
	sol = solve(prob, Tsit5())
	# Get displacement
	ts = msd_prob.tspan[1]:dt:msd_prob.tspan[2]
	x = map(t->sol(t)[2], ts)
	# Get number of frames
	frames = length(x)	
	# Normalize displacement
	x_norm = (x.-minimum(x))./(maximum(x)-minimum(x))
	# Fit to frame dimensions
	x_frame =  (frame_width-2*box_half_width-4*spring_length-space).*x_norm .- (frame_width-2*box_half_width-4*spring_length-space)/2
	# Convert to Points
	x_points = Point.(x_frame, 0)
	# Set background
	function ground(args...) 
    	background("white") # canvas background
    	sethue("black") # pen color
	end
	# Create workspace
	myvideo = Video(frame_width, frame_height)
	# Set background
	Background(1:frames, ground)
	# Create box for mass
	box = Javis.Object(1:frames,JBox(Point(box_half_width,box_half_height), Point(-box_half_width,-box_half_height), color = "black", action = :stroke))
	# Make box follow path
	act!(
		box, 
		Action(
			1:frames, 
			Animations.linear(),
			follow_path(x_points; closed = false)
		)		
	)
	# Create reference frame
	ref_frame = Javis.Object(@JShape begin
		sethue("black")
		useless
		P1 = Point(-frame_width/2, -box_half_height*1.5)
		P2 = P1 + Point(0, box_half_height*2.5)
		P3 = P2+Point(frame_width, 0)
		line(P1, P2)
		line(P2, P3)
	end	useless = pos(box)+spring_offset)
	#  Make the spring line
	spring_offset = Point(0,box_half_height/2)
	idx_spring = 1
	max_tension = maximum(sol[msd_bg[:k].e])
	normalized_spring_force = (sol[msd_bg[:k].e])./(max_tension)
	spring = Javis.Object(@JShape begin
		Δx = abs(p2[1]-p1[1])/2
		midpoint = Point(p1[1]+Δx, p1[2])
		setcolor(0.0,0.0,0.0)
		# setcolor(normalized_spring_force[idx_spring], 1.0-normalized_spring_force[idx_spring], 0.0)
		idx_spring+=1
		line(p1,midpoint-Point(spring_segment*6, 0), :stroke)
		line(midpoint+Point(spring_segment*6, 0), p2, :stroke)
		p3 = midpoint-Point(spring_segment, spring_height/2)
		line(midpoint, p3, :stroke)
		p4 = p3 - Point(spring_segment, -spring_height/2)
		line(p3, p4, :stroke)
		p5 = p4 - Point(spring_segment, -spring_height/2)
		line(p4, p5, :stroke)
		p6 = p5 - Point(spring_segment, spring_height/2)
		line(p5, p6, :stroke)
		p7 = p6 - Point(spring_segment, spring_height/2)
		line(p6, p7, :stroke)
		p8 = p7 - Point(spring_segment, -spring_height/2)
		line(p7, p8, :stroke)
		p9 = midpoint+Point(spring_segment, spring_height/2)
		line(midpoint, p9, :stroke)
		p10 = p9 + Point(spring_segment, -spring_height/2)
		line(p9, p10, :stroke)
		p11 = p10 + Point(spring_segment, -spring_height/2)
		line(p10, p11, :stroke)
		p12 = p11 + Point(spring_segment, spring_height/2)
		line(p11, p12, :stroke)
		p13 = p12 + Point(spring_segment, spring_height/2)
		line(p12, p13, :stroke)
		p14 = p13 + Point(spring_segment, -spring_height/2)
		line(p13, p14, :stroke)
	end	p2 = pos(box)+spring_offset p1 = Point(-frame_width/2, -box_half_height)+spring_offset)
	#  Make the damper line
	damper_offset = Point(0,3*box_half_height/2)
	max_tension = maximum(sol[msd_bg[:b].e])
	max_compression = minimum(sol[msd_bg[:b].e])
	normalized_damper_force = (sol[msd_bg[:b].e] .- max_compression)./(max_tension - max_compression)
	idx_damper = 1
	damper = Javis.Object(@JShape begin
		Δx = abs(p2[1]-p1[1])/2
		midpoint = Point(p1[1]+Δx, p1[2])
		setcolor(0.0,0.0,0.0)
		# setcolor(normalized_damper_force[idx_damper], 1.0-normalized_damper_force[idx_damper], 0.0)
		idx_damper+=1
		line(p1,midpoint-Point(damper_length/2, 0), :stroke)
		line(midpoint+Point(damper_length/2, 0), p2, :stroke)
		p3 = midpoint-Point(damper_length/2, 0)
		line(p3+Point(0,damper_height/6),p3-Point(0,damper_height/6), :stroke)
		p4 = midpoint-Point(damper_length/2, 0)+Point(0, -damper_height/2)
		p5 = p4 + Point(damper_length, 0)
		line(p4, p5, :stroke)
		p6 = p5 - Point(0, -damper_height)
		line(p5, p6, :stroke)
		p7 = p6 - Point(damper_length, 0)
		line(p6, p7, :stroke)
	end	p2 = pos(box)+damper_offset p1 = Point(-frame_width/2, -box_half_height)+damper_offset)

	# Render the Gif
	# anim = Javis.render(
 #    	myvideo;
 #    	pathname="circle.gif",
	# 	,
	# 	liveview = false
	# )
	JavisNB.embed(myvideo, pathname = "msd.gif", framerate = Int(round(1/dt)))
end
end
  ╠═╡ =#

# ╔═╡ b3c795a2-ec44-4bec-bb81-859c072cea1a
ThreeColumn(HTML("m = "*string(m_val)),HTML("k = "*string(k_val)),HTML("b = "*string(b_val)))

# ╔═╡ 726b43e2-3385-46d9-a6d9-630ca3097a4e
ThreeColumn(
	Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/robot_example.jpg")
	,Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/motor_with_control.png"),
md"""
### State equations reduced from Bond Graph
`math
\begin{align}
	\frac{dk\tau_{+}q(t)}{dt} =& \frac{Rw_{+}R\ \ \ \mathrm{k\tau_{+}q}\left( t \right) - T_{+}r\ \ \ ec_{+}Se\ \ \ k\tau_{+}C}{ - T_{+}r^{2}\ \ \  k\tau_{+}C} + \frac{ - \mathrm{J_{+}p}\left( t \right)}{J_{+}I} \\
	\frac{dJ_{+}p(t)}{dt} =& {\tau}d_{+}Se + \frac{\mathrm{k\tau_{+}q}\left( t \right)}{k\tau_{+}C} - R_{+}R \frac{\mathrm{J_{+}p}\left( t \right)}{J_{+}I}
\end{align}
`
""")

# ╔═╡ b6f89c8d-dd75-47fa-adff-542f6a9948e4
TwoColumn(md"""
 $K_{ff}$ = $(@bind kff_gain PlutoUI.Slider(0.1:0.1:1.0, default = 0.9, show_value = true))

 $K_{fb}$ = $(@bind kfb_gain PlutoUI.Slider(0.1:0.1:5.0, default = 0.5, show_value = true))

 $K_P$ = $(@bind kp PlutoUI.Slider(0.0:0.1:30.0, default = 0.1, show_value = true))

 $K_I$ = $(@bind ki PlutoUI.Slider(0.1:0.1:30.0, default = 0.1, show_value = true))

 $K_D$ = $(@bind kd PlutoUI.Slider(0.0:0.1:7.0, default = 0.0, show_value = true))
""",md"""
 $Q_{1,1}$ = $(@bind Q11 PlutoUI.Slider(25:48, show_value = true, default = 29))
 
 $Q_{1,2} = Q_{2,1}$ = $(@bind Q12 PlutoUI.Slider(0.0:0.5:24.0, show_value = true, default = 21.5))

 $Q_{1,3} = Q_{3,1}$ = $(@bind Q13 PlutoUI.Slider(-40:40, show_value = true, default = 1.0))

 $Q_{2,2}$ = $(@bind Q22 PlutoUI.Slider(1:40, show_value = true, default = 16.0))
 
 $Q_{2,3} = Q_{3,2}$ = $(@bind Q23 PlutoUI.Slider(-3.0:0.1:100.0, show_value = true, default = 1.0))

 $Q_{3,3}$ = $(@bind Q33 PlutoUI.Slider(1:200, show_value = true, default = 10.0))
""")

# ╔═╡ a51db68b-4223-467b-8913-2df443b65f08
let
	Φr(e, f, t, p) = p[2] * e + 1 / 2 * (p[1] - p[2]) * (abs(e + p[3]) - abs(e - p[3]))
	v1 = range(-2, 2, length = 101)
	p = [20.0, 0.895, 1]
	f(v) = Φr(v, 0, 0, p)
	plt = Plot(
		Config(
			x = v1, 
			y = f.(v1)
		)
	)
	plt.layout = Config(
				xaxis = Config(
					title = "Voltage",
					mirror = true,
					ticks="outside",
					showline=true,
					zeroline=false,
					),
				yaxis = Config(
					title = "Current",
					mirror = true,
					ticks="outside",
					showline=true,
					zeroline=false,
					),

				# images = [Config(
				# 	source = "https://raw.githubusercontent.com/cfarm6/BondGraphPictures/main/images/chua_new.png",
				# 	x = -0.65, 
				# 	y = 0.5,
				# 	xref = "paper",
				# 	yref = "paper",
				# 	sizex = 0.8, 
				# 	sizey = 0.8,
				# 	xanchor = "left",
				# 	yanchor = "middle", 
				# ),
				# ],
				margin = Config(t = 50),
				annotations = [
					Config(
						text = "Resistor Voltage-Current Relationship for GN",
						font = Config(size = 20),
						showarrow=false,
						align = "center",
						x = 0.55,
						xref = "paper",
						y = 1.2,
						yref = "paper",
					),
					]
			)	
	TwoColumn(Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/chua_new.png"), plt)
	# plt
	# TwoColumn(LocalResource("./images/chua.png"), plt)
end

# ╔═╡ a77fbba5-0183-47f8-9adc-741660f197bc
TwoColumn(Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/tesla_car.png"), Resource("https://github.com/cfarm6/BondGraphPictures/raw/main/images/active_quarter_car_bondgraph.png"))

# ╔═╡ d89c896a-a735-40b7-a2d7-567151957b2d
TwoColumn(md"""
### Data Collection Options
Number of samples = $(@bind ex_surrogate Select([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]))

Lower Frequency Bounds [Hz] = $(@bind ω_lower confirm(TextField(default = "1")))

Upper Frequency Bounds [Hz] = $(@bind ω_upper confirm(TextField(default = "10")))

Maximum Time [s] = $(@bind t_stop confirm(TextField(default = "5.0")))
""",
	md"""
	### Surrogate Options
	$(@bind surrogate_model Radio([
	"Linear Surrogate", 
	"Second Order Polynomial Surrogate", 
	"Random Forest Surrogate",
	], default = "Linear Surrogate"))
	"""
)

# ╔═╡ 3fbacefc-1863-4e45-b0df-118a09ff48b5
ex10_sys, ex10_prob, ex10_p = let
	@parameters α ω
	@named sys = ODESystem(substitute.(full_equations(car_sys), (Dict(car_bg[:vin].Sf => α*sin(ω*car_sys.iv)), )), car_sys.iv, observed = observed(car_sys))
	sys = structural_simplify(sys)
	u0 = [
		car_bg[:kt].q  => 0.0,
		car_bg[:mus].p => 0.0, 
		car_bg[:ms].p  => 0.0,
		car_bg[:ks].q  => 0.0,
		car_bg[:L].p   => 0.0
	]
	p = [
		car_bg[:kt].C  => 1/100.0,
		car_bg[:ks].C  => 1/100.0,
		car_bg[:ms].I  => 15.0,
		car_bg[:mus].I => 10.0,
		car_bg[:bs].R  => 5.0,
		car_bg[:Volt].Se => 0.0,
		car_bg[:GY].r  => 0.9,
		car_bg[:L].I   => 1e-3,
		car_bg[:R].R   => 5.0,
		α => 1.0,
		ω => parse(Float64, ω_lower)*2π
	]|>Dict
	tspan = (0.0, 5.0)
	prob = ODAEProblem(sys, u0, tspan, p)
	sys, prob,p 
end;

# ╔═╡ c2f0968f-ed70-46c2-8d43-c18d1a2fbbb7
let
	# -- Make the initial Conditions and parameter dicts
	@parameters α ω
	u0 = [
		car_bg[:kt].q  => 0.0,
		car_bg[:mus].p => 0.0, 
		car_bg[:ms].p  => 0.0,
		car_bg[:ks].q  => 0.0,
		car_bg[:L].p   => 0.0
	]
	p = [
		car_bg[:kt].C  => 1/100.0,
		car_bg[:ks].C  => 1/100.0,
		car_bg[:ms].I  => 15.0,
		car_bg[:mus].I => 10.0,
		car_bg[:bs].R  => 5.0,
		car_bg[:GY].r  => 0.9,
		car_bg[:L].I   => 1e-3,
		car_bg[:R].R   => 5.0,
	]|>Dict
	tspan = (0.0, 20.0)
	eqs = substitute.(full_equations(ex10_sys), (Dict(α => 1.0, ω => diffeqparamfreq*2π, car_bg[:Volt].Se => 0.0),))
	@named sys = ODESystem(eqs, ex10_sys.iv)
	sys = structural_simplify(sys)
	prob = ODAEProblem(sys, u0, tspan, p)
	orig_prob = deepcopy(prob)
	# -- Make some data
	sol = solve(prob, Tsit5())
	t = collect(range(0,stop=10,length=200))
	noisy_vars=[
		car_bg[:kt].q  => 0,
		car_bg[:mus].p => 1, 
		car_bg[:ms].p  => 1,
		car_bg[:ks].q  => 0,
		car_bg[:L].p   => 0
	]
	noise_vars = ModelingToolkit.varmap_to_vars(noisy_vars, states(sys))
	function generate_data(sol,t)
  		randomized = VectorOfArray([(sol(t[i]) + noise_vars.*meas_noise*randn()) for i in 1:length(t)])
  		data = convert(Array,randomized)
	end
	data = convert(Array,VectorOfArray([generate_data(sol,t) for i in 1:100]))
	cost_function = build_loss_objective(prob,Tsit5(), L2Loss(t,data), verbose=false)	# distributions = [fit_mle(Normal,aggregate_data[i,j,:]) for i in 1:5, j in 1:200]
	plb = ModelingToolkit.varmap_to_vars(p, ModelingToolkit.parameters(sys))./2
	pub = ModelingToolkit.varmap_to_vars(p, ModelingToolkit.parameters(sys)).*1.1
	res = Optim.optimize(cost_function, pub, Optim.Options(iterations=25))
	bc = res.minimizer
	best_dict = Dict(ModelingToolkit.parameters(sys) .=> bc)
	rel_error = Dict([k=>abs(p[k]-best_dict[k])/abs(p[k]) for k in keys(p)])
	new_prob = remake(orig_prob, p = bc)
	new_sol = solve(new_prob, Tsit5())
	data1 = Config(
		x = sol.t, 
		y = sol[car_bg[:ms].p],
		name = "True Solution"
	)	
	data2 = Config(
		x = new_sol.t, 
		y = new_sol[car_bg[:ms].p],
		name = "Approximated"
	)
	p = Plot([data1, data2])
	p.layout.yaxis.title = "Rider Momentum"
	p.layout.xaxis.title = "Time [s]"
	p
end

# ╔═╡ 72c5ab8b-b027-4329-839d-9fc8792d5670
xs, ys, lb, ub, sim = let
	@parameters ω α
	ks_q_idx = indexin([car_bg[:ms].p], states(ex10_sys))
	# Create the samples
	function sim(x)
		ex10_p[ω] = x[1]*2π
		new_prob = remake(ex10_prob, 
			p = ModelingToolkit.varmap_to_vars(ex10_p, ModelingToolkit.parameters(ex10_sys)),
		 	tspan = (0.0, x[2]))
		sol = solve(new_prob, Tsit5(), dense = false)
		return first(last(sol)[ks_q_idx])
	end
	n_samples = Int(round(ex_surrogate))
	lb = [parse(Float64, ω_lower)*2π,   1e-3]
	ub = [parse(Float64, ω_upper)*2π, parse(Float64, t_stop)]
	xs = Surrogates.sample(n_samples, lb, ub, LatinHypercubeSample())
	ys = sim.(xs)
	xs, ys, lb, ub, sim
end;

# ╔═╡ 9e613044-0e9d-4939-947c-780a597b9fbf
surr = let
	if surrogate_model == "Kriging"
		surr = Surrogates.Kriging(xs, ys, lb, ub, p = [1.9])
	elseif surrogate_model == "Random Forest Surrogate"
		surr = RandomForestSurrogate(xs, ys, lb, ub, num_round = 50)
	elseif surrogate_model == "Linear Surrogate"
		surr = LinearSurrogate(xs, ys, lb, ub)
	elseif surrogate_model == "Second Order Polynomial Surrogate"
		surr = Surrogates.SecondOrderPolynomialSurrogate(xs, ys, lb, ub)
	end
	surrogate_optimize(sim, SRBF(), lb, ub, surr, SobolSample())
	surr
end;

# ╔═╡ f174b5bc-0dab-417d-8eb2-6c504f6612a8
md"""
Test Frequency[Hz] = $(@bind surr_freq confirm(Slider(range(parse(Float64, ω_lower), parse(Float64, ω_upper), length = 101), show_value = true, default = (parse(Float64, ω_upper) + parse(Float64, ω_lower))/2)))
"""

# ╔═╡ 399d25e1-65fd-4249-b99a-34b1759dbd15
let
	ts = range(0.0, parse(Float64, t_stop), length = 100)
	true_qs(t) = sim([surr_freq*2π, t])
	surr_qs(t) = surr([surr_freq*2π, t])
	relerror = abs.(true_qs.(ts).-surr_qs.(ts))./abs.(true_qs.(ts)).*100
	d1 = Config(
		x = ts,
		y = true_qs.(ts),
		name = "True",
		xaxis = "x1",
		yaxis = "y1",
	)
	d2 = Config(
		x = ts, 
		y = surr_qs.(ts),
		name = "Surrogate",
		xaxis = "x1", 
		yaxis = "y1",
	)
	d3 = Config(
		x = ts[2:end], 
		y = relerror[2:end],
		name = "Relative Error",
		xaxis = "x2",
		yaxis = "y2",
	)
	p = Plot([d1, d2, d3])
	p.layout.grid = Config(rows = 1, columns = 2, pattern = "independent")
	p.layout.yaxis2.type = "log"
	p.layout.xaxis1.title = "Time [s]"
	p.layout.xaxis2.title = "Time [s]"
	p.layout.yaxis1.title = "Amplitude"
	p.layout.yaxis2.title = "Relative Error [%]"
	p
end

# ╔═╡ Cell order:
# ╟─d3060600-ffd4-4668-925e-cc89e665ae39
# ╟─03454da0-2b50-43b1-9c42-af17ad2ce9e1
# ╟─f10215ec-2ddb-4764-b03e-f567a2e41d81
# ╟─96c84fc8-8731-49dc-8ff3-6a9e7aa5c30e
# ╟─8b9b4121-d42d-420a-b18e-b345f70df1db
# ╟─c23bbe41-9b5f-4834-b19e-8ebb73c5e4f0
# ╟─eb458bd2-4add-4c50-a95b-913bc849bcfa
# ╟─707337fe-ce18-4a62-9ba5-96d951b001fd
# ╟─82c777cd-4fc1-4ba7-a06a-382d79c7e0cd
# ╟─618735ce-bf2e-405e-b57c-0d9516e4da0a
# ╟─677df42f-b439-4b0e-ae81-4a724fb2d971
# ╟─197bb937-cae3-4142-a68a-7beee63fac4c
# ╟─5a130c47-a151-41a6-8cce-42388b9513fa
# ╟─9a532355-5b2b-4c89-9e1c-a31bec2dd575
# ╟─0e113ade-bac7-4088-97f9-019b95fbfd72
# ╟─4aea0fc8-8b26-4a3f-883c-392f9e714c68
# ╟─a218d7b0-28d5-4855-bbec-132eaa42ec40
# ╟─6bc65d66-234e-43db-84ad-562121493a8a
# ╟─3dac7556-2226-46c5-b2fa-2650323a8c22
# ╟─abbef45c-3c9d-4dfb-a3b2-a7150e2252bf
# ╟─0e5e89e6-909e-4781-9817-682bc82fdc33
# ╟─99d1f985-11c9-4afc-b4c0-d9033217a291
# ╟─f50f1b34-edf5-4372-85c6-e5757af05f72
# ╟─e35b9427-5940-41dd-8d4c-5f3f23cac61f
# ╟─549d0da7-fa71-446e-8e6c-89fa5bc641ee
# ╟─b81438fb-78b1-4b3b-afa8-16a18fd7001f
# ╟─5228d2a5-e1b3-4964-b876-5b83b281809b
# ╟─ee966448-556b-4ce1-980e-8b65e80d556e
# ╟─14f2de65-f15f-4759-8fc4-6844c0cd2de4
# ╟─81a48fa2-d497-4934-bbfa-23f53212bc47
# ╟─4269cc94-40b8-4cb8-8042-2a257532b3a0
# ╟─d42d451b-e1df-444e-af25-e4dd0346f17e
# ╟─416bd3ab-bfd6-4470-a1d4-3e577b037421
# ╟─1db6c69a-0ce0-4ed7-b0a2-df35f610b241
# ╟─87deb82f-1fde-4479-a7c6-1d3010edcc87
# ╟─d6717b74-a638-4551-891a-2f14349a4769
# ╟─5678ff7f-b168-4798-802d-63e4eb6742d5
# ╟─7ab72fc2-34f8-45ab-8cf7-ce87ef576891
# ╟─5cd2a593-256d-4d2f-af31-fb46ffa2a6f2
# ╟─51eb45c5-b97b-4b9a-895a-11f2497a43a0
# ╟─b0417a15-e141-4230-93ec-e0a2caac8d4c
# ╟─8508c5b8-5846-4707-989b-d90f68b21414
# ╟─1b9ed3d7-435a-40e8-a2c4-14d8d1bfacf3
# ╟─0dfb115e-d5c7-401c-8664-7e0dd08e43e1
# ╟─539584e5-0018-4620-a310-21449d2baaef
# ╟─1b0c8c7f-9e25-44a9-84b5-d8be12b67ee3
# ╟─05899b77-fc58-4556-ba9e-2969f3746ff4
# ╟─3f09a83c-01e5-4932-b4b9-b34a0e4a951a
# ╟─327a1dc7-ab8b-477b-8dec-00bf381c76cf
# ╟─3f4bc834-5f99-40e3-8f80-35b934881dd7
# ╟─b3c795a2-ec44-4bec-bb81-859c072cea1a
# ╟─3e43d179-ec6a-42dc-b25f-e651ccfca429
# ╟─f9f57858-01c5-49b5-a718-a0af8f34eb3c
# ╟─0ddd71bc-ea00-4cb0-838a-7b51f702ca6b
# ╠═8cb4d629-489a-461a-b9ca-3492b434f15f
# ╟─832be2af-d3e7-45d1-be8e-05a210c4173d
# ╟─bff336f2-ce8d-4653-b417-3d70f121232d
# ╟─cac617ec-48eb-49ae-83a1-8b68658170d0
# ╟─726b43e2-3385-46d9-a6d9-630ca3097a4e
# ╟─09338c5f-26ed-447a-ba92-37c4437df35a
# ╟─ad53d7b6-4370-4367-b53d-34da2a72312e
# ╟─fd102b04-83f1-40db-a541-c010fd07602d
# ╟─bc8ba6de-1ead-4ff1-a4cc-74c085f9dfc9
# ╟─49c5a12e-a71a-441e-ab2a-91ee3e3a39f3
# ╟─1c76f7f2-8113-47ec-a77c-e520937f9ea1
# ╟─adedcd94-e5db-438b-a1ba-2375ef40faaa
# ╟─58527c5b-b1c3-417a-b8fe-4bafda16f948
# ╟─38c127ad-a802-4915-866c-f2b9f39b2633
# ╟─392d57e3-86c7-43b1-918d-5ebede3ffe75
# ╟─cb3f9e19-0ca0-41a3-b60a-c8a24543e05d
# ╟─59cada5a-72ef-4574-ab04-b4d5eb8f6b74
# ╟─b6f89c8d-dd75-47fa-adff-542f6a9948e4
# ╠═433cf2d5-465f-45cc-a16d-cab455fb03fa
# ╟─e90c7cfe-88c0-4a2e-adb4-1f09e028de30
# ╟─21a3f32a-b66a-4fbc-9358-958bc5960611
# ╟─a51db68b-4223-467b-8913-2df443b65f08
# ╟─8fb74ff6-20d2-4852-9f7e-a138e781206b
# ╟─b4d99c41-0327-45ad-88fe-2e259ce4b8e5
# ╟─bbf58762-06a5-492c-8045-f619464d3612
# ╟─b1508c1f-a38e-4572-b1f5-d9e006dbd8d5
# ╟─d2c9241c-c284-4b8c-b31b-3120f6595354
# ╟─f33f326d-2e4a-4ea0-a0c3-5dfcec9e368e
# ╟─dd61ae6e-3adb-49df-bacd-40971356170c
# ╟─1ed90a5e-a795-4f53-8c4c-c2c3c0bdae2d
# ╟─914956d2-f31c-456a-8f97-e5007d88a463
# ╟─a2f4dc21-aff8-4a57-9e09-25be9b91db1f
# ╟─591bec61-3234-460f-adf0-578db0852265
# ╟─ae8384e6-673b-4e0e-8051-843b3cadc218
# ╟─7b9e6197-72e1-4902-a146-0328d49788ce
# ╟─5e231fcd-ac2a-4c68-a4ee-1e1e958a6ae1
# ╟─dcf30937-c327-4f5f-af11-f5f4c0e5e2a7
# ╟─9123967c-326a-4aa7-a055-865436fe2f49
# ╟─a77fbba5-0183-47f8-9adc-741660f197bc
# ╟─548d9407-ffb8-4dde-a84d-9090c16b2419
# ╟─db62accd-623e-41b4-aa1c-347ddfa1335c
# ╟─47a83bd1-8f2f-4c3e-94c9-d899769b1ae9
# ╟─6d187607-71a3-4524-96f9-73fd6dd98c46
# ╟─3df3f656-0737-4606-84d9-db214d44bf44
# ╟─49f0d0ee-703d-4995-b51e-946822415e12
# ╟─9ba77432-a5e3-4f79-94da-f034a8976aff
# ╟─45c057fc-473e-4864-9ade-47f4a0e0d154
# ╟─8fe705ed-4085-411c-bbfc-ac99e47ea57d
# ╟─66a2687c-af4d-4155-a332-8e9faeeae4b5
# ╟─3fbacefc-1863-4e45-b0df-118a09ff48b5
# ╟─d89c896a-a735-40b7-a2d7-567151957b2d
# ╟─72c5ab8b-b027-4329-839d-9fc8792d5670
# ╟─9e613044-0e9d-4939-947c-780a597b9fbf
# ╟─f174b5bc-0dab-417d-8eb2-6c504f6612a8
# ╟─399d25e1-65fd-4249-b99a-34b1759dbd15
# ╟─817312ea-13a1-4947-ad65-53b9166879dd
# ╟─40b6a34d-d693-4dc1-a07d-8aeadb16e6b3
# ╟─c2f0968f-ed70-46c2-8d43-c18d1a2fbbb7
# ╟─6001d7f1-12f4-4c6c-9fa8-b8a6a8c6251c
# ╟─a1e33edc-ca6c-45ae-828b-312d6e0542d1
# ╟─e1126ec3-b5e5-4981-9438-ac7a2e1b6f38
# ╟─72416995-ac8e-43e2-80d2-1ca84cf11da7
# ╟─636d0760-4d33-4e28-99f1-040a0748c799
# ╟─a1b21817-ea48-4002-a80f-1960e5d12d54
# ╟─a21b4b2a-96f2-4168-96ca-0666055975c7
# ╠═511a9463-65eb-4ac0-baff-f8c386638c54
# ╟─a81168cd-eb9c-47d9-bdc3-bd2a2566a273
# ╟─f7af0b08-66f1-4b3f-aca5-2291f8d18306
# ╟─3844323c-8579-409c-a7bd-5b423b8c610b
# ╟─42043350-3ffd-4186-9bc1-382fd88d080c
# ╟─7905f3bd-7c91-448d-952e-06e18c5761ae
# ╟─1a241b91-9da2-4f89-85de-1e8e8f3b8dc4
# ╟─5ba902c1-f88e-4881-a204-60ce5fd7d80b
