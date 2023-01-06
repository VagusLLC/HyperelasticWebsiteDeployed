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

# ╔═╡ 20f1c638-5cec-11ec-2a1c-899c59354ba8
begin
	import Pkg
	dev = Pkg.develop
	local_dir = joinpath(splitpath(@__FILE__)[1:end-1])
	dev([Pkg.PackageSpec(path=joinpath(local_dir, "BondGraphs"))])
	using BondGraphs
end

# ╔═╡ 40676685-a013-4876-9d51-cbf83461ce75
using Unitful

# ╔═╡ 9fa4a109-33ac-42d6-8ebe-ba77f1c2b0eb
using Latexify

# ╔═╡ 7bdffbfd-b9aa-42b0-b663-c15e09235c9b
using RecursiveArrayTools

# ╔═╡ 6c92195b-6017-407c-becb-aaf03ebdd88c
using Flux

# ╔═╡ 8e199596-c642-4d13-92b6-e72e64d49518
using LinearAlgebra

# ╔═╡ 48be1803-9ad4-4180-8825-b24a1e43bfc6
using Distributions

# ╔═╡ 0b56d185-2767-43f1-90bb-0bc31c78f64a
using ModelingToolkit

# ╔═╡ 635f3ab7-97a0-47c8-ad28-bde405f64612
using PlotlyLight

# ╔═╡ 0a510171-a1ae-4a20-8704-775f498ecaa7
using Surrogates

# ╔═╡ fa90b940-0e77-4b51-a7a9-e1be0c7fb791
using Measurements

# ╔═╡ 9989439d-04c6-418b-80c1-cf9d60ca9b0d
using DifferentialEquations

# ╔═╡ 4c1df659-29f1-431e-91d7-afef6defbab1
begin
	using Animations
	using BlackBoxOptim
	using ControlSystems
end

# ╔═╡ c7676d9b-ff93-483e-9963-a69be391dbf0
using Optim

# ╔═╡ 6e5659c6-cd5f-4f1b-8243-78f3e04a8dab
using MonteCarloMeasurements

# ╔═╡ fb0de123-da02-4982-a489-95fa9c87868a
using DataDrivenDiffEq

# ╔═╡ 81f19bcf-4099-4b70-abc6-f204f4a6b7ee
using LaTeXStrings

# ╔═╡ 20fbf450-5de2-4685-943b-51d6ecb26fc6
using DiffEqParamEstim

# ╔═╡ f2beb5c7-0cc9-4f73-8086-f9784c8bf86f
using DynamicalSystems

# ╔═╡ 7068c916-d48a-485b-9d2a-34e0c6e71451
using Statistics

# ╔═╡ f071ac10-fe88-4af1-baa2-2d30a0a3af76
using Javis

# ╔═╡ 0db7c33a-db7a-4c2f-bae2-c54d6e68435e
using Colors

# ╔═╡ 5356a88f-f2c8-43f6-ad6d-1a8ebe42928d
using PlutoUI

# ╔═╡ a34a4b59-5da7-413a-95a8-47bf8cbf338d
using JavisNB

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

# ╔═╡ 03915951-c40f-4814-a99c-fbca03edaaba
# using DataDrivenDiffEq

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

# ╔═╡ 59cada5a-72ef-4574-ab04-b4d5eb8f6b74
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

# ╔═╡ 433cf2d5-465f-45cc-a16d-cab455fb03fa
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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Animations = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
BlackBoxOptim = "a134a8b2-14d6-55f6-9291-3336d3ab0209"
BondGraphs = "81b6dc42-80d7-44f0-b878-76c33e6b41d1"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
ControlSystems = "a6e380b2-a6ca-5380-bf3e-84a91bcd477e"
DataDrivenDiffEq = "2445eb08-9709-466a-b3fc-47e12bd697a2"
DiffEqParamEstim = "1130ab10-4a5a-5621-a13d-e4788d82bd4c"
DifferentialEquations = "0c46a032-eb83-5123-abaf-570d42b7fbaa"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
DynamicalSystems = "61744808-ddfa-5f27-97ff-6e42cc95d634"
Flux = "587475ba-b771-5e3f-ad9e-33799f191a9c"
Javis = "78b212ba-a7f9-42d4-b726-60726080707e"
JavisNB = "92afb270-2599-44f6-96a1-44c6efb1daf1"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
ModelingToolkit = "961ee093-0014-501f-94e3-6117800e7a78"
MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
Optim = "429524aa-4258-5aef-a3af-852621145aeb"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlotlyLight = "ca7969ec-10b3-423e-8d99-40f33abb42bf"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
RecursiveArrayTools = "731186ca-8d62-57ce-b412-fbd966d074cd"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
Surrogates = "6fc51010-71bc-11e9-0e15-a3fcc6593c49"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
Animations = "~0.4.1"
BlackBoxOptim = "~0.6.2"
BondGraphs = "~0.1.5"
Colors = "~0.12.10"
ControlSystems = "~1.5.3"
DataDrivenDiffEq = "~1.0.2"
DiffEqParamEstim = "~2.0.1"
DifferentialEquations = "~7.6.0"
Distributions = "~0.25.79"
DynamicalSystems = "~2.3.2"
Flux = "~0.13.11"
Javis = "~0.8.0"
JavisNB = "~0.1.0"
LaTeXStrings = "~1.3.0"
Latexify = "~0.15.17"
Measurements = "~2.8.0"
ModelingToolkit = "~8.40.0"
MonteCarloMeasurements = "~1.0.12"
Optim = "~1.7.4"
PlotlyLight = "~0.6.0"
PlutoUI = "~0.7.49"
RecursiveArrayTools = "~2.34.1"
Surrogates = "~6.5.1"
Unitful = "~1.12.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.4"
manifest_format = "2.0"
project_hash = "3fa1cc28841ca045d6711770e2dfccb7084ac2e7"

[[deps.ATK_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "58c36d8a1beeb12d63921bcfaa674baf30a1140e"
uuid = "7b86fcea-f67b-53e1-809c-8f1719c154e8"
version = "2.36.1+0"

[[deps.AbstractAlgebra]]
deps = ["GroupsCore", "InteractiveUtils", "LinearAlgebra", "MacroTools", "Markdown", "Random", "RandomExtensions", "SparseArrays", "Test"]
git-tree-sha1 = "7772df04fda9bc25a44c9ef61e9dc7c92bb35d86"
uuid = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
version = "0.27.7"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "69f7020bd72f069c219b5e8c236c1fa90d2cb409"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.2.1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.Accessors]]
deps = ["Compat", "CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "LinearAlgebra", "MacroTools", "Requires", "Test"]
git-tree-sha1 = "3fa8cc751763c91a5ea33331e523221009cb1e6f"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.23"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.Animations]]
deps = ["Colors"]
git-tree-sha1 = "e81c509d2c8e49592413bfb0bb3b08150056c79d"
uuid = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
version = "0.4.1"

[[deps.ArgCheck]]
git-tree-sha1 = "a3a402a35a2f7e0b87828ccabbd5ebfbebe356b4"
uuid = "dce04be8-c92d-5529-be00-80e4d2c0e197"
version = "2.3.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.ArrayInterface]]
deps = ["ArrayInterfaceCore", "Compat", "IfElse", "LinearAlgebra", "Static"]
git-tree-sha1 = "6d0918cb9c0d3db7fe56bea2bc8638fc4014ac35"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "6.0.24"

[[deps.ArrayInterfaceCore]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "14c3f84a763848906ac681f94cf469a851601d92"
uuid = "30b0a656-2188-435a-8636-2ec0e6a096e2"
version = "0.1.28"

[[deps.ArrayInterfaceGPUArrays]]
deps = ["Adapt", "ArrayInterfaceCore", "GPUArraysCore", "LinearAlgebra"]
git-tree-sha1 = "fc114f550b93d4c79632c2ada2924635aabfa5ed"
uuid = "6ba088a2-8465-4c0a-af30-387133b534db"
version = "0.2.2"

[[deps.ArrayInterfaceOffsetArrays]]
deps = ["ArrayInterface", "OffsetArrays", "Static"]
git-tree-sha1 = "3d1a9a01976971063b3930d1aed1d9c4af0817f8"
uuid = "015c0d05-e682-4f19-8f0a-679ce4c54826"
version = "0.1.7"

[[deps.ArrayInterfaceStaticArrays]]
deps = ["Adapt", "ArrayInterface", "ArrayInterfaceCore", "ArrayInterfaceStaticArraysCore", "LinearAlgebra", "Static", "StaticArrays"]
git-tree-sha1 = "f12dc65aef03d0a49650b20b2fdaf184928fd886"
uuid = "b0d46f97-bff5-4637-a19a-dd75974142cd"
version = "0.1.5"

[[deps.ArrayInterfaceStaticArraysCore]]
deps = ["Adapt", "ArrayInterfaceCore", "LinearAlgebra", "StaticArraysCore"]
git-tree-sha1 = "93c8ba53d8d26e124a5a8d4ec914c3a16e6a0970"
uuid = "dd5226c6-a4d4-4bc7-8575-46859f9c95b9"
version = "0.1.3"

[[deps.ArrayLayouts]]
deps = ["FillArrays", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "4aff5fa660eb95c2e0deb6bcdabe4d9a96bc4667"
uuid = "4c555306-a7a7-4459-81d9-ec55ddd5c99a"
version = "0.8.18"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AssetRegistry]]
deps = ["Distributed", "JSON", "Pidfile", "SHA", "Test"]
git-tree-sha1 = "b25e88db7944f98789130d7b503276bc34bc098e"
uuid = "bf4720bc-e11a-5d0c-854e-bdca1663c893"
version = "0.1.0"

[[deps.AutoHashEquals]]
git-tree-sha1 = "45bb6705d93be619b81451bb2006b7ee5d4e4453"
uuid = "15f4f7f2-30c1-5605-9d31-71845cf9641f"
version = "0.2.0"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "1dd4d9f5beebac0c03446918741b1a03dc5e5788"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.6"

[[deps.BFloat16s]]
deps = ["LinearAlgebra", "Printf", "Random", "Test"]
git-tree-sha1 = "a598ecb0d717092b5539dbbe890c98bac842b072"
uuid = "ab4f0b2a-ad5b-11e8-123f-65d77653426b"
version = "0.2.0"

[[deps.BandedMatrices]]
deps = ["ArrayLayouts", "FillArrays", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "134fe629f08ca56f07b1d8028736dab437df34f5"
uuid = "aae01518-5342-5314-be14-df237901396f"
version = "0.17.9"

[[deps.BangBang]]
deps = ["Compat", "ConstructionBase", "Future", "InitialValues", "LinearAlgebra", "Requires", "Setfield", "Tables", "ZygoteRules"]
git-tree-sha1 = "7fe6d92c4f281cf4ca6f2fba0ce7b299742da7ca"
uuid = "198e06fe-97b7-11e9-32a5-e1d131e6ad66"
version = "0.3.37"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Baselet]]
git-tree-sha1 = "aebf55e6d7795e02ca500a689d326ac979aaf89e"
uuid = "9718e550-a3fa-408a-8086-8db961cd8217"
version = "0.1.1"

[[deps.Bijections]]
git-tree-sha1 = "fe4f8c5ee7f76f2198d5c2a06d3961c249cce7bd"
uuid = "e2ed5e7c-b2de-5872-ae92-c73ca462fb04"
version = "0.1.4"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "0c5f81f47bbbcf4aea7b2959135713459170798b"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.5"

[[deps.BlackBoxOptim]]
deps = ["CPUTime", "Compat", "Distributed", "Distributions", "HTTP", "JSON", "LinearAlgebra", "Printf", "Random", "SpatialIndexing", "StatsBase"]
git-tree-sha1 = "136079f37e3514ec691926093924b591a8842f5d"
uuid = "a134a8b2-14d6-55f6-9291-3336d3ab0209"
version = "0.6.2"

[[deps.BondGraphs]]
deps = ["DifferentialEquations", "FileIO", "GraphIO", "Graphs", "LinearAlgebra", "MetaGraphs", "ModelingToolkit", "SymbolicUtils", "Symbolics"]
path = "/home/carson/.julia/dev/BondGraphs"
uuid = "81b6dc42-80d7-44f0-b878-76c33e6b41d1"
version = "0.1.5"

[[deps.BoundaryValueDiffEq]]
deps = ["BandedMatrices", "DiffEqBase", "FiniteDiff", "ForwardDiff", "LinearAlgebra", "NLsolve", "Reexport", "SciMLBase", "SparseArrays"]
git-tree-sha1 = "ed8e837bfb3d1e3157022c9636ec1c722b637318"
uuid = "764a87c0-6b3e-53db-9096-fe964310641d"
version = "2.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "Static"]
git-tree-sha1 = "a7157ab6bcda173f533db4c93fc8a27a48843757"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.1.30"

[[deps.CPUTime]]
git-tree-sha1 = "2dcc50ea6a0a1ef6440d6eecd0fe3813e5671f45"
uuid = "a9c8d775-2e2e-55fc-8582-045d282d599e"
version = "1.0.0"

[[deps.CRlibm]]
deps = ["CRlibm_jll"]
git-tree-sha1 = "32abd86e3c2025db5172aa182b982debed519834"
uuid = "96374032-68de-5a5b-8d9e-752f78720389"
version = "1.0.1"

[[deps.CRlibm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e329286945d0cfc04456972ea732551869af1cfc"
uuid = "4e9b3aee-d8a1-5a3d-ad8b-7d824db253f0"
version = "1.0.1+0"

[[deps.CSSUtil]]
deps = ["Colors", "JSON", "Markdown", "Measures", "WebIO"]
git-tree-sha1 = "b9fb4b464ec10e860abe251b91d4d049934f7399"
uuid = "70588ee8-6100-5070-97c1-3cb50ed05fe8"
version = "0.1.1"

[[deps.CSTParser]]
deps = ["Tokenize"]
git-tree-sha1 = "3ddd48d200eb8ddf9cb3e0189fc059fd49b97c1f"
uuid = "00ebfdb7-1f24-5e51-bd34-a7502290713f"
version = "3.3.6"

[[deps.CUDA]]
deps = ["AbstractFFTs", "Adapt", "BFloat16s", "CEnum", "CompilerSupportLibraries_jll", "ExprTools", "GPUArrays", "GPUCompiler", "LLVM", "LazyArtifacts", "Libdl", "LinearAlgebra", "Logging", "Printf", "Random", "Random123", "RandomNumbers", "Reexport", "Requires", "SparseArrays", "SpecialFunctions", "TimerOutputs"]
git-tree-sha1 = "a56dff7bc49b5d5ac43d2c10eb2aef94becd5251"
uuid = "052768ef-5323-5732-b1bb-66c8b64840ba"
version = "3.12.1"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "d0b3f8b4ad16cb0a2988c6788646a5e6a17b6b1b"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.0.5"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRules]]
deps = ["Adapt", "ChainRulesCore", "Compat", "Distributed", "GPUArraysCore", "IrrationalConstants", "LinearAlgebra", "Random", "RealDot", "SparseArrays", "Statistics", "StructArrays"]
git-tree-sha1 = "99a39b0f807499510e2ea14b0eef8422082aa372"
uuid = "082447d4-558c-5d27-93f4-14fc19e9eca2"
version = "1.46.0"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e7ff6cadf743c098e08fca25c91103ee4303c9bb"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.6"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.ChaosTools]]
deps = ["Clustering", "Combinatorics", "DSP", "DelayEmbeddings", "Distances", "Distributions", "DynamicalSystemsBase", "Entropies", "ForwardDiff", "IntervalRootFinding", "LinearAlgebra", "LombScargle", "Neighborhood", "ProgressMeter", "Random", "Roots", "SpecialFunctions", "StaticArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "85e8370059f8fcbd99d437d86bbac472cbab9a98"
uuid = "608a59af-f2a3-5ad4-90b4-758bdf3122a7"
version = "2.9.0"

[[deps.CloseOpenIntervals]]
deps = ["ArrayInterface", "Static"]
git-tree-sha1 = "d61300b9895f129f4bd684b2aff97cf319b6c493"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.11"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "64df3da1d2a26f4de23871cd1b6482bb68092bd5"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.14.3"

[[deps.Cobweb]]
deps = ["DefaultApplication", "Markdown", "Scratch", "StructTypes"]
git-tree-sha1 = "8d7424cdf54a42eedf9b8d6c6fa10a7a361b4029"
uuid = "ec354790-cf28-43e8-bb59-b484409b7bad"
version = "0.2.3"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "86cce6fd164c26bad346cc51ca736e692c9f553c"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.7"

[[deps.CommonSolve]]
git-tree-sha1 = "9441451ee712d1aec22edad62db1a9af3dc8d852"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.3"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "00a2cccc7f098ff3b66806862d275ca3db9e6e5a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.5.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.CompositeTypes]]
git-tree-sha1 = "02d2316b7ffceff992f3096ae48c7829a8aa0638"
uuid = "b152e2b5-7a66-4b01-a709-34e65c35f657"
version = "0.1.3"

[[deps.CompositionsBase]]
git-tree-sha1 = "455419f7e328a1a2493cabc6428d79e951349769"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.1"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "fb21ddd70a051d882a1686a5a550990bbe371a95"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.4.1"

[[deps.ContextVariablesX]]
deps = ["Compat", "Logging", "UUIDs"]
git-tree-sha1 = "25cc3803f1030ab855e383129dcd3dc294e322cc"
uuid = "6add18c4-b38d-439d-96f6-d6bc489c04c5"
version = "0.1.3"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.ControlSystems]]
deps = ["ControlSystemsBase", "DelayDiffEq", "DiffEqCallbacks", "ForwardDiff", "Hungarian", "LinearAlgebra", "OrdinaryDiffEq", "Printf", "Random", "RecipesBase", "Reexport", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "b57cbafaa65213741dea15226e2d63a571b184d1"
uuid = "a6e380b2-a6ca-5380-bf3e-84a91bcd477e"
version = "1.5.3"

[[deps.ControlSystemsBase]]
deps = ["DSP", "ForwardDiff", "IterTools", "LaTeXStrings", "LinearAlgebra", "MacroTools", "MatrixEquations", "MatrixPencils", "Polyester", "Polynomials", "Printf", "Random", "RecipesBase", "SparseArrays", "StaticArrays", "UUIDs"]
git-tree-sha1 = "607020e70948ac11fc4187117cb6d892a835c5f4"
uuid = "aaaaaaaa-a6ca-5380-bf3e-84a91bcd477e"
version = "1.2.1"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "681ea870b918e7cff7111da58791d7f718067a19"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.2"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DSP]]
deps = ["Compat", "FFTW", "IterTools", "LinearAlgebra", "Polynomials", "Random", "Reexport", "SpecialFunctions", "Statistics"]
git-tree-sha1 = "da8b06f89fce9996443010ef92572b193f8dca1f"
uuid = "717857b8-e6f2-59f4-9121-6e50c889abd2"
version = "0.7.8"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataDrivenDiffEq]]
deps = ["CommonSolve", "DataInterpolations", "DiffEqBase", "DocStringExtensions", "LinearAlgebra", "MLUtils", "ModelingToolkit", "Parameters", "ProgressMeter", "QuadGK", "Random", "RecipesBase", "Reexport", "Setfield", "Statistics", "StatsBase", "Test"]
git-tree-sha1 = "bf4405628f0528e5c1beea2ba45f7adc80280ffc"
uuid = "2445eb08-9709-466a-b3fc-47e12bd697a2"
version = "1.0.2"

[[deps.DataInterpolations]]
deps = ["ChainRulesCore", "LinearAlgebra", "Optim", "RecipesBase", "RecursiveArrayTools", "Reexport", "RegularizationTools", "Symbolics"]
git-tree-sha1 = "cd5e1d85ca89521b7df86eb343bb129799d92b15"
uuid = "82cc6244-b520-54b8-b5a6-8a565e85f1d0"
version = "3.10.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "97f1325c10bd02b1cc1882e9c2bf6407ba630ace"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.12.16+3"

[[deps.DefaultApplication]]
deps = ["InteractiveUtils"]
git-tree-sha1 = "c0dfa5a35710a193d83f03124356eef3386688fc"
uuid = "3f0dd361-4fe0-5fc6-8523-80b14ec94d85"
version = "1.1.0"

[[deps.DefineSingletons]]
git-tree-sha1 = "0fba8b706d0178b4dc7fd44a96a92382c9065c2c"
uuid = "244e2a9f-e319-4986-a169-4d1fe445cd52"
version = "0.1.2"

[[deps.DelayDiffEq]]
deps = ["ArrayInterface", "DataStructures", "DiffEqBase", "LinearAlgebra", "Logging", "OrdinaryDiffEq", "Printf", "RecursiveArrayTools", "Reexport", "SciMLBase", "SimpleNonlinearSolve", "UnPack"]
git-tree-sha1 = "478408ad9195fce93f2837a18519fbe7f7795b6d"
uuid = "bcd4f6db-9728-5f36-b5f7-82caef46ccdb"
version = "5.40.5"

[[deps.DelayEmbeddings]]
deps = ["Distances", "Distributions", "LinearAlgebra", "Neighborhood", "Random", "StaticArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "0189145d6299367d9c27f686e3510354902f61ca"
uuid = "5732040d-69e3-5649-938a-b6b4f237613f"
version = "2.4.1"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "633c119fcfddf61fb4c75d77ce3ebab552a44723"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.2"

[[deps.Dierckx_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6596b96fe1caff3db36415eeb6e9d3b50bfe40ee"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.1.0+0"

[[deps.DiffEqBase]]
deps = ["ArrayInterfaceCore", "ChainRulesCore", "DataStructures", "Distributions", "DocStringExtensions", "FastBroadcast", "ForwardDiff", "FunctionWrappers", "FunctionWrappersWrappers", "LinearAlgebra", "Logging", "MuladdMacro", "Parameters", "PreallocationTools", "Printf", "RecursiveArrayTools", "Reexport", "Requires", "SciMLBase", "Setfield", "SimpleNonlinearSolve", "SparseArrays", "Static", "StaticArrays", "Statistics", "Tricks", "ZygoteRules"]
git-tree-sha1 = "29777943a9e73c7d6b47d93830038ebdaacc18db"
uuid = "2b5f629d-d688-5b77-993f-72d75c75574e"
version = "6.113.0"

[[deps.DiffEqCallbacks]]
deps = ["DataStructures", "DiffEqBase", "ForwardDiff", "LinearAlgebra", "Markdown", "NLsolve", "Parameters", "RecipesBase", "RecursiveArrayTools", "SciMLBase", "StaticArrays"]
git-tree-sha1 = "485503846a90b59f3b79b39c2d818496bf50d197"
uuid = "459566f4-90b8-5000-8ac3-15dfb0a30def"
version = "2.24.3"

[[deps.DiffEqNoiseProcess]]
deps = ["DiffEqBase", "Distributions", "GPUArraysCore", "LinearAlgebra", "Markdown", "Optim", "PoissonRandom", "QuadGK", "Random", "Random123", "RandomNumbers", "RecipesBase", "RecursiveArrayTools", "ResettableStacks", "SciMLBase", "StaticArrays", "Statistics"]
git-tree-sha1 = "27350a71ca46c85a0bcdf7dca3b966f218c08f9a"
uuid = "77a26b50-5914-5dd7-bc55-306e6241c503"
version = "5.15.0"

[[deps.DiffEqParamEstim]]
deps = ["Calculus", "Dierckx", "DiffEqBase", "Distributions", "LinearAlgebra", "PenaltyFunctions", "PreallocationTools", "RecursiveArrayTools", "SciMLBase"]
git-tree-sha1 = "18419c960b6249b636a89d9e9ad7601c43d45095"
uuid = "1130ab10-4a5a-5621-a13d-e4788d82bd4c"
version = "2.0.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "c5b6685d53f933c11404a3ae9822afe30d522494"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.12.2"

[[deps.DifferentialEquations]]
deps = ["BoundaryValueDiffEq", "DelayDiffEq", "DiffEqBase", "DiffEqCallbacks", "DiffEqNoiseProcess", "JumpProcesses", "LinearAlgebra", "LinearSolve", "OrdinaryDiffEq", "Random", "RecursiveArrayTools", "Reexport", "SciMLBase", "SteadyStateDiffEq", "StochasticDiffEq", "Sundials"]
git-tree-sha1 = "418dad2cfd7377a474326bc86a23cb645fac6527"
uuid = "0c46a032-eb83-5123-abaf-570d42b7fbaa"
version = "7.6.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "a7756d098cbabec6b3ac44f369f74915e8cfd70a"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.79"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.DomainSets]]
deps = ["CompositeTypes", "IntervalSets", "LinearAlgebra", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "988e2db482abeb69efc76ae8b6eba2e93805ee70"
uuid = "5b8099bc-c8ec-5219-889f-1d9e522a28bf"
version = "0.5.15"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.DynamicPolynomials]]
deps = ["DataStructures", "Future", "LinearAlgebra", "MultivariatePolynomials", "MutableArithmetics", "Pkg", "Reexport", "Test"]
git-tree-sha1 = "d0fa82f39c2a5cdb3ee385ad52bc05c42cb4b9f0"
uuid = "7c1d4256-1411-5781-91ec-d7bc3513ac07"
version = "0.4.5"

[[deps.DynamicalSystems]]
deps = ["ChaosTools", "DelayEmbeddings", "DynamicalSystemsBase", "Entropies", "RecurrenceAnalysis", "Reexport", "Scratch"]
git-tree-sha1 = "2072127d6e93f69a6d489824f43839c60b99138e"
uuid = "61744808-ddfa-5f27-97ff-6e42cc95d634"
version = "2.3.2"

[[deps.DynamicalSystemsBase]]
deps = ["DelayEmbeddings", "ForwardDiff", "LinearAlgebra", "SciMLBase", "SimpleDiffEq", "SparseArrays", "StaticArrays", "Statistics"]
git-tree-sha1 = "f22f893ff0b327b7cd6bf68c1cdcb323ee16c156"
uuid = "6e36e845-645a-534a-86f2-f5d4aa5a06b4"
version = "2.8.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.EasyConfig]]
deps = ["JSON3", "OrderedCollections", "StructTypes"]
git-tree-sha1 = "c070b3c48a8ba3c6e6507997f0a7f5ebf85c3600"
uuid = "acab07b0-f158-46d4-8913-50acef6d41fe"
version = "0.1.10"

[[deps.EllipsisNotation]]
deps = ["ArrayInterface"]
git-tree-sha1 = "03b753748fd193a7f2730c02d880da27c5a24508"
uuid = "da5c29d0-fa7d-589e-88eb-ea29b0a81949"
version = "1.6.0"

[[deps.Entropies]]
deps = ["DelayEmbeddings", "Distances", "LinearAlgebra", "Neighborhood", "SparseArrays", "SpecialFunctions", "StaticArrays", "Statistics", "Wavelets"]
git-tree-sha1 = "6da8090e8e49cebf107647b988b536492b8deb74"
uuid = "ed8fcbec-b94c-44b6-89df-898894ad9591"
version = "1.1.2"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.ErrorfreeArithmetic]]
git-tree-sha1 = "d6863c556f1142a061532e79f611aa46be201686"
uuid = "90fa49ef-747e-5e6f-a989-263ba693cf1a"
version = "0.5.2"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.ExponentialUtilities]]
deps = ["Adapt", "ArrayInterfaceCore", "ArrayInterfaceGPUArrays", "GPUArraysCore", "GenericSchur", "LinearAlgebra", "Printf", "SparseArrays", "libblastrampoline_jll"]
git-tree-sha1 = "9837d3f3a904c7a7ab9337759c0093d3abea1d81"
uuid = "d4d017d3-3776-5f7e-afef-a10c40355c18"
version = "1.22.0"

[[deps.ExprTools]]
git-tree-sha1 = "56559bbef6ca5ea0c0818fa5c90320398a6fbf8d"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.8"

[[deps.ExtendableSparse]]
deps = ["DocStringExtensions", "LinearAlgebra", "Printf", "Requires", "SparseArrays", "SuiteSparse", "Test"]
git-tree-sha1 = "f6fe89c275ae1b6af8ed20bb94f6fbd40fc63177"
uuid = "95c220a8-a1cf-11e9-0c77-dbfce5f500b3"
version = "0.6.8"

[[deps.Extents]]
git-tree-sha1 = "5e1e4c53fa39afe63a7d356e30452249365fba99"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "90630efff0894f8142308e334473eba54c433549"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.5.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FLoops]]
deps = ["BangBang", "Compat", "FLoopsBase", "InitialValues", "JuliaVariables", "MLStyle", "Serialization", "Setfield", "Transducers"]
git-tree-sha1 = "ffb97765602e3cbe59a0589d237bf07f245a8576"
uuid = "cc61a311-1640-44b5-9fba-1b764f453329"
version = "0.2.1"

[[deps.FLoopsBase]]
deps = ["ContextVariablesX"]
git-tree-sha1 = "656f7a6859be8673bf1f35da5670246b923964f7"
uuid = "b9860ae5-e623-471e-878b-f6a53c775ea6"
version = "0.1.1"

[[deps.FastBroadcast]]
deps = ["ArrayInterface", "ArrayInterfaceCore", "LinearAlgebra", "Polyester", "Static", "StrideArraysCore"]
git-tree-sha1 = "4bef892787c972913d4d84e7255400759bb650e5"
uuid = "7034ab61-46d4-4ed7-9d0f-46aef9175898"
version = "0.2.4"

[[deps.FastClosures]]
git-tree-sha1 = "acebe244d53ee1b461970f8910c235b259e772ef"
uuid = "9aa1b823-49e4-5ca5-8b0f-3971ec8bab6a"
version = "0.3.2"

[[deps.FastLapackInterface]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "7fbaf9f73cd4c8561702ea9b16acf3f99d913fe4"
uuid = "29a986be-02c6-4525-aec4-84b980013641"
version = "1.2.8"

[[deps.FastRounding]]
deps = ["ErrorfreeArithmetic", "LinearAlgebra"]
git-tree-sha1 = "6344aa18f654196be82e62816935225b3b9abe44"
uuid = "fa42c844-2597-5d31-933b-ebd51ab2693f"
version = "0.3.1"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "7be5f99f7d15578798f338f5433b6c432ea8037b"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "9a0472ec2f5409db243160a8b030f94c380167a3"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.6"

[[deps.FiniteDiff]]
deps = ["ArrayInterfaceCore", "LinearAlgebra", "Requires", "Setfield", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "04ed1f0029b6b3af88343e439b995141cb0d0b8d"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.17.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Flux]]
deps = ["Adapt", "CUDA", "ChainRulesCore", "Functors", "LinearAlgebra", "MLUtils", "MacroTools", "NNlib", "NNlibCUDA", "OneHotArrays", "Optimisers", "ProgressLogging", "Random", "Reexport", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "Zygote"]
git-tree-sha1 = "518b553ec3776dde058aebd2750c109d04ee5593"
uuid = "587475ba-b771-5e3f-ad9e-33799f191a9c"
version = "0.13.11"

[[deps.FoldsThreads]]
deps = ["Accessors", "FunctionWrappers", "InitialValues", "SplittablesBase", "Transducers"]
git-tree-sha1 = "eb8e1989b9028f7e0985b4268dabe94682249025"
uuid = "9c68100b-dfe1-47cf-94c8-95104e173443"
version = "0.1.1"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "a69dd6db8a809f78846ff259298678f0d6212180"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.34"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "cabd77ab6a6fdff49bfd24af2ebe76e6e018a2b4"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.0.0"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "b5c7fe9cea653443736d264b85466bad8c574f4a"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.9.9"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.FunctionWrappers]]
git-tree-sha1 = "d62485945ce5ae9c0c48f124a84998d755bae00e"
uuid = "069b7b12-0de2-55c6-9aab-29f3d0a68a2e"
version = "1.1.3"

[[deps.FunctionWrappersWrappers]]
deps = ["FunctionWrappers"]
git-tree-sha1 = "a5e6e7f12607e90d71b09e6ce2c965e41b337968"
uuid = "77dc65aa-8811-40c2-897b-53d922fa7daf"
version = "0.1.1"

[[deps.FunctionalCollections]]
deps = ["Test"]
git-tree-sha1 = "04cb9cfaa6ba5311973994fe3496ddec19b6292a"
uuid = "de31a74c-ac4f-5751-b3fd-e18cd04993ca"
version = "0.5.0"

[[deps.Functors]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "993c2b4a9a54496b6d8e265db1244db418f37e01"
uuid = "d9f16b24-f501-4c13-a1f2-28368ffc5196"
version = "0.4.1"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLM]]
deps = ["Distributions", "LinearAlgebra", "Printf", "Reexport", "SparseArrays", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns", "StatsModels"]
git-tree-sha1 = "884477b9886a52a84378275737e2823a5c98e349"
uuid = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
version = "1.8.1"

[[deps.GPUArrays]]
deps = ["Adapt", "GPUArraysCore", "LLVM", "LinearAlgebra", "Printf", "Random", "Reexport", "Serialization", "Statistics"]
git-tree-sha1 = "45d7deaf05cbb44116ba785d147c518ab46352d7"
uuid = "0c68f7d7-f131-5f86-a1c3-88cf8149b2d7"
version = "8.5.0"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "6872f5ec8fd1a38880f027a26739d42dcda6691f"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.2"

[[deps.GPUCompiler]]
deps = ["ExprTools", "InteractiveUtils", "LLVM", "Libdl", "Logging", "TimerOutputs", "UUIDs"]
git-tree-sha1 = "48832a7cacbe56e591a7bef690c78b9d00bcc692"
uuid = "61eb1bfa-7361-4325-ad38-22787b887f55"
version = "0.17.1"

[[deps.GTK3_jll]]
deps = ["ATK_jll", "Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Libepoxy_jll", "Pango_jll", "Pkg", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXcomposite_jll", "Xorg_libXcursor_jll", "Xorg_libXdamage_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "Xorg_libXrender_jll", "at_spi2_atk_jll", "gdk_pixbuf_jll", "iso_codes_jll", "xkbcommon_jll"]
git-tree-sha1 = "b080a592525632d287aee4637a62682576b7f5e4"
uuid = "77ec8976-b24b-556a-a1bf-49a033a670a6"
version = "3.24.31+0"

[[deps.GenericSchur]]
deps = ["LinearAlgebra", "Printf"]
git-tree-sha1 = "fb69b2a645fa69ba5f474af09221b9308b160ce6"
uuid = "c145ed77-6b09-5dd9-b285-bf645a82121e"
version = "0.5.3"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "fb28b5dc239d0174d7297310ef7b84a11804dfab"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.0.1"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "fe9aea4ed3ec6afdfbeb5a4f39a2208909b162a6"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.5"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "78e2c69783c9753a91cdae88a8d432be85a2ab5e"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Glob]]
git-tree-sha1 = "4df9f7e06108728ebf00a0a11edee4b29a482bb2"
uuid = "c27321d9-0574-5035-807b-f59d2c89b15c"
version = "1.3.0"

[[deps.GraphIO]]
deps = ["DelimitedFiles", "Graphs", "Requires", "SimpleTraits"]
git-tree-sha1 = "c243b56234de8afbb6838129e72a4dfccd230ccc"
uuid = "aa1b3936-2fda-51b9-ab35-c553d3a640a2"
version = "0.6.0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "ba2d094a88b6b287bd25cfa86f301e7693ffae2f"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.7.4"

[[deps.Groebner]]
deps = ["AbstractAlgebra", "Combinatorics", "Logging", "MultivariatePolynomials", "Primes", "Random"]
git-tree-sha1 = "47f0f03eddecd7ad59c42b1dd46d5f42916aff63"
uuid = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
version = "0.2.11"

[[deps.GroupsCore]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9e1a5e9f3b81ad6a5c613d181664a0efc6fe6dd7"
uuid = "d5909c97-4eac-4ecc-a3dc-fdd0858a4120"
version = "0.4.0"

[[deps.Gtk]]
deps = ["Cairo", "Cairo_jll", "Dates", "GTK3_jll", "Glib_jll", "Graphics", "JLLWrappers", "Libdl", "Librsvg_jll", "Pkg", "Reexport", "Scratch", "Serialization", "Test", "Xorg_xkeyboard_config_jll", "adwaita_icon_theme_jll", "gdk_pixbuf_jll", "hicolor_icon_theme_jll"]
git-tree-sha1 = "b502c9f626930385658f818edc62218956204fb4"
uuid = "4c0ca9eb-093a-5379-98c5-f87ac0bbbf44"
version = "1.3.0"

[[deps.GtkReactive]]
deps = ["Cairo", "Colors", "Dates", "FixedPointNumbers", "Graphics", "Gtk", "IntervalSets", "Reactive", "Reexport", "RoundingIntegers"]
git-tree-sha1 = "ccb07a5fa45e43ac83b6795c9e218d6a802c93d8"
uuid = "27996c0f-39cd-5cc1-a27a-05f136f946b6"
version = "1.0.6"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "f64b890b2efa4de81520d2b0fbdc9aadb65bdf53"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.13"

[[deps.Hungarian]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "371a7df7a6cce5909d6c576f234a2da2e3fa0c98"
uuid = "e91730f6-4275-51fb-a7a0-7064cfbd3b39"
version = "0.6.0"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IRTools]]
deps = ["InteractiveUtils", "MacroTools", "Test"]
git-tree-sha1 = "2e99184fca5eb6f075944b04c22edec29beb4778"
uuid = "7869d1d1-7146-5819-86e3-90919afe41df"
version = "0.4.7"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "c54b581a83008dc7f292e205f4c409ab5caa0f04"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.10"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageContrastAdjustment]]
deps = ["ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "0d75cafa80cf22026cea21a8e6cf965295003edc"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.10"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "b1798a4a6b9aafb530f8f0c4a7b2eb5501e2f2a3"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.16"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "Reexport", "SnoopPrecompile", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "f265e53558fbbf23e0d54e4fab7106c0f2a9e576"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.3"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "342f789fd041a55166764c351da1710db97ce0e0"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.6"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils", "Libdl", "Pkg", "Random"]
git-tree-sha1 = "5bc1cb62e0c5f1005868358db0692c994c3a13c6"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.1"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "124626988534986113cfd876e3093e4a03890f58"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.12+3"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "36cbaebed194b292590cba2593da27b34763804a"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.8"

[[deps.ImageMorphology]]
deps = ["ImageCore", "LinearAlgebra", "Requires", "TiledIteration"]
git-tree-sha1 = "e7c68ab3df4a75511ba33fc5d8d9098007b579a8"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.3.2"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "5985d467623f106523ed8351f255642b5141e7be"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.4"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "36832067ea220818d105d718527d6ed02385bf22"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.7.0"

[[deps.ImageShow]]
deps = ["Base64", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "b563cf9ae75a635592fc73d3eb78b86220e55bd8"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.6"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "ColorVectorSpace", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "8717482f4a2108c9358e5c3ca903d3a6113badc9"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.9.5"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "03d1301b7ec885b266c0f816f338368c6c0b81bd"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.25.2"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "87f7662e03a649cffa2e05bf19c303e168732d3e"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InitialValues]]
git-tree-sha1 = "4da0f88e9a39111c2fa3add390ab15f3a44f3ca3"
uuid = "22cec73e-a1b8-11e9-2c92-598750a2cf9c"
version = "0.3.1"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "0cf92ec945125946352f3d46c96976ab972bde6f"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.3.2"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "f366daebdfb079fd1fe4e3d560f99a0c892e15bc"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.0"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.Interact]]
deps = ["CSSUtil", "InteractBase", "JSON", "Knockout", "Observables", "OrderedCollections", "Reexport", "WebIO", "Widgets"]
git-tree-sha1 = "c5091992248c7134af7c90554305c600d5d9012b"
uuid = "c601a237-2ae4-5e1e-952c-7a85b0c7eef1"
version = "0.10.5"

[[deps.InteractBase]]
deps = ["Base64", "CSSUtil", "Colors", "Dates", "JSExpr", "JSON", "Knockout", "Observables", "OrderedCollections", "Random", "WebIO", "Widgets"]
git-tree-sha1 = "dc5a846040f1607740e29e582b6e66251b9ecf9d"
uuid = "d3863d7c-f0c8-5437-a7b4-3ae773c01009"
version = "0.10.9"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "721ec2cf720536ad005cb38f50dbba7b02419a15"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.7"

[[deps.IntervalArithmetic]]
deps = ["CRlibm", "FastRounding", "LinearAlgebra", "Markdown", "Random", "RecipesBase", "RoundingEmulator", "SetRounding", "StaticArrays"]
git-tree-sha1 = "c1c88395d09366dae431556bcb598ad08fa1392b"
uuid = "d1acc4aa-44c8-5952-acd4-ba5d80a2a253"
version = "0.20.8"

[[deps.IntervalRootFinding]]
deps = ["ForwardDiff", "IntervalArithmetic", "LinearAlgebra", "Polynomials", "Reexport", "StaticArrays"]
git-tree-sha1 = "b6969692c800cc5b90608fbd3be83189edc5e446"
uuid = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
version = "0.5.10"

[[deps.IntervalSets]]
deps = ["Dates", "EllipsisNotation", "Statistics"]
git-tree-sha1 = "bcf640979ee55b652f3b01650444eb7bbe3ea837"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.5.4"

[[deps.Intervals]]
deps = ["Dates", "Printf", "RecipesBase", "Serialization", "TimeZones"]
git-tree-sha1 = "f3c7f871d642d244e7a27e3fb81e8441e13230d8"
uuid = "d8418881-c3e1-53bb-8760-2df7ec849ed5"
version = "1.8.0"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IterativeSolvers]]
deps = ["LinearAlgebra", "Printf", "Random", "RecipesBase", "SparseArrays"]
git-tree-sha1 = "1169632f425f79429f245113b775a0e3d121457c"
uuid = "42fd0dbc-a981-5370-80f2-aaf504508153"
version = "0.9.2"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "Printf", "Reexport", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "ec8a9c9f0ecb1c687e34c1fda2699de4d054672a"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.29"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSExpr]]
deps = ["JSON", "MacroTools", "Observables", "WebIO"]
git-tree-sha1 = "b413a73785b98474d8af24fd4c8a975e31df3658"
uuid = "97c1335a-c9c5-57fe-bc5d-ec35cebe8660"
version = "0.5.4"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "SnoopPrecompile", "StructTypes", "UUIDs"]
git-tree-sha1 = "84b10656a41ef564c39d2d477d7236966d2b5683"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.12.0"

[[deps.Javis]]
deps = ["Animations", "Cairo", "FFMPEG", "Gtk", "GtkReactive", "Hungarian", "ImageIO", "ImageMagick", "Images", "Interact", "LaTeXStrings", "LightXML", "Luxor", "ProgressMeter", "Random", "Statistics", "VideoIO"]
git-tree-sha1 = "e296ec984115cd23a1a01e9d05dc708c96a1a995"
uuid = "78b212ba-a7f9-42d4-b726-60726080707e"
version = "0.8.0"

[[deps.JavisNB]]
deps = ["Interact", "Javis"]
git-tree-sha1 = "48746b8dcc0f7853de8b36829f734780ffd79ab6"
uuid = "92afb270-2599-44f6-96a1-44c6efb1daf1"
version = "0.1.0"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "a77b273f1ddec645d1b7c4fd5fb98c8f90ad10a5"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.JuliaFormatter]]
deps = ["CSTParser", "CommonMark", "DataStructures", "Glob", "Pkg", "Tokenize"]
git-tree-sha1 = "447f5702b5271d99f064e924061bc05e26f52c4c"
uuid = "98e50ef6-434e-11e9-1051-2b60c6c9e899"
version = "1.0.18"

[[deps.JuliaVariables]]
deps = ["MLStyle", "NameResolution"]
git-tree-sha1 = "49fb3cb53362ddadb4415e9b73926d6b40709e70"
uuid = "b14d175d-62b4-44ba-8fb7-3064adc8c3ec"
version = "0.2.4"

[[deps.JumpProcesses]]
deps = ["ArrayInterfaceCore", "DataStructures", "DiffEqBase", "DocStringExtensions", "FunctionWrappers", "Graphs", "LinearAlgebra", "Markdown", "PoissonRandom", "Random", "RandomNumbers", "RecursiveArrayTools", "Reexport", "SciMLBase", "StaticArrays", "TreeViews", "UnPack"]
git-tree-sha1 = "09ed2720b2e343e48780a3156c4a6cef8dd54192"
uuid = "ccbc3e58-028d-4f4c-8cd5-9ae44345cda5"
version = "9.3.1"

[[deps.Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

[[deps.KLU]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse_jll"]
git-tree-sha1 = "764164ed65c30738750965d55652db9c94c59bfe"
uuid = "ef3ab10e-7fda-4108-b977-705223b18434"
version = "0.4.0"

[[deps.Knockout]]
deps = ["JSExpr", "JSON", "Observables", "Test", "WebIO"]
git-tree-sha1 = "91835de56d816864f1c38fb5e3fad6eb1e741271"
uuid = "bcebb21b-c2e3-54f8-a781-646b90f6d2cc"
version = "0.2.6"

[[deps.Krylov]]
deps = ["LinearAlgebra", "Printf", "SparseArrays"]
git-tree-sha1 = "dd90aacbfb622f898a97c2a4411ac49101ebab8a"
uuid = "ba0b0d4f-ebba-5204-a429-3ac8c609bfb7"
version = "0.9.0"

[[deps.KrylovKit]]
deps = ["ChainRulesCore", "GPUArraysCore", "LinearAlgebra", "Printf"]
git-tree-sha1 = "1a5e1d9941c783b0119897d29f2eb665d876ecf3"
uuid = "0b1a1467-8014-51b9-945f-bf0ae24f4b77"
version = "0.6.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVM]]
deps = ["CEnum", "LLVMExtra_jll", "Libdl", "Printf", "Unicode"]
git-tree-sha1 = "088dd02b2797f0233d92583562ab669de8517fd1"
uuid = "929cbde3-209d-540e-8aea-75f648917ca0"
version = "4.14.1"

[[deps.LLVMExtra_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg", "TOML"]
git-tree-sha1 = "771bfe376249626d3ca12bcd58ba243d3f961576"
uuid = "dad2f222-ce93-54a1-a47d-0025e8a3acab"
version = "0.0.16+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.LabelledArrays]]
deps = ["ArrayInterfaceCore", "ArrayInterfaceStaticArrays", "ArrayInterfaceStaticArraysCore", "ChainRulesCore", "ForwardDiff", "LinearAlgebra", "MacroTools", "PreallocationTools", "RecursiveArrayTools", "StaticArrays"]
git-tree-sha1 = "dae002226b59701dbafd7e2dd757df1bd83442fd"
uuid = "2ee39098-c373-598a-b85f-a56591580800"
version = "1.12.5"

[[deps.LambertW]]
git-tree-sha1 = "2d9f4009c486ef676646bca06419ac02061c088e"
uuid = "984bce1d-4616-540c-a9ee-88d1112d94c9"
version = "0.4.5"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "ab9aa169d2160129beb241cb2750ca499b4e90e9"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.17"

[[deps.LatinHypercubeSampling]]
deps = ["Random", "StableRNGs", "StatsBase", "Test"]
git-tree-sha1 = "42938ab65e9ed3c3029a8d2c58382ca75bdab243"
uuid = "a5e1c1ea-c99a-51d3-a14d-a9a37257b02d"
version = "1.8.0"

[[deps.LatticeRules]]
deps = ["Random"]
git-tree-sha1 = "7f5b02258a3ca0221a6a9710b0a0a2e8fb4957fe"
uuid = "73f95e8e-ec14-4e6a-8b18-0d2e271c4e55"
version = "0.0.1"

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "ArrayInterfaceOffsetArrays", "ArrayInterfaceStaticArrays", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static"]
git-tree-sha1 = "7e34177793212f6d64d045ee47d2883f09fffacc"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.12"

[[deps.Lazy]]
deps = ["MacroTools"]
git-tree-sha1 = "1370f8202dac30758f3c345f9909b97f53d87d3f"
uuid = "50d2b5c4-7a5e-59d5-8109-a42b560f39c0"
version = "0.15.1"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LeastSquaresOptim]]
deps = ["FiniteDiff", "ForwardDiff", "LinearAlgebra", "Optim", "Printf", "SparseArrays", "Statistics", "SuiteSparse"]
git-tree-sha1 = "06ea4a7c438f434dc0dc8d03c72e61ee0bf3629d"
uuid = "0fc2ff8b-aaa3-5acd-a817-1944a5e08891"
version = "0.8.3"

[[deps.LevyArea]]
deps = ["LinearAlgebra", "Random", "SpecialFunctions"]
git-tree-sha1 = "56513a09b8e0ae6485f34401ea9e2f31357958ec"
uuid = "2d8b4e74-eb68-11e8-0fb9-d5eb67b50637"
version = "1.0.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libepoxy_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "7a0158b71f8be5c771e7a273183b2d0ac35278c5"
uuid = "42c93a91-0102-5b3f-8f9d-e41de60ac950"
version = "1.5.10+0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Librsvg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pango_jll", "Pkg", "gdk_pixbuf_jll"]
git-tree-sha1 = "ae0923dab7324e6bc980834f709c4cd83dd797ed"
uuid = "925c91fb-5dd6-59dd-8e8c-345e74382d89"
version = "2.54.5+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LightXML]]
deps = ["Libdl", "XML2_jll"]
git-tree-sha1 = "e129d9391168c677cd4800f5c0abb1ed8cb3794f"
uuid = "9c8b4983-aa76-5018-a973-4c85ecc9e179"
version = "0.9.0"

[[deps.LineSearches]]
deps = ["LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "Printf"]
git-tree-sha1 = "7bbea35cec17305fc70a0e5b4641477dc0789d9d"
uuid = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
version = "7.2.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LinearMaps]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics"]
git-tree-sha1 = "d1b46faefb7c2f48fdec69e6f3cc34857769bc15"
uuid = "7a12625a-238d-50fd-b39a-03d52299707e"
version = "3.8.0"

[[deps.LinearSolve]]
deps = ["ArrayInterfaceCore", "DocStringExtensions", "FastLapackInterface", "GPUArraysCore", "IterativeSolvers", "KLU", "Krylov", "KrylovKit", "LinearAlgebra", "Preferences", "RecursiveFactorization", "Reexport", "SciMLBase", "Setfield", "SnoopPrecompile", "SparseArrays", "Sparspak", "SuiteSparse", "UnPack"]
git-tree-sha1 = "cf1227e369513687658476e466a5b73a7c3dfa1f"
uuid = "7ed4a6bd-45f5-4d41-b270-4a48e9bafcae"
version = "1.33.0"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "946607f84feb96220f480e0422d3484c49c00239"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.19"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LombScargle]]
deps = ["FFTW", "LinearAlgebra", "Measurements", "Random", "SpecialFunctions", "Statistics"]
git-tree-sha1 = "d64a0ce7539181136a85fd8fe4f42626387f0f26"
uuid = "fc60dff9-86e7-5f2f-a8a0-edeadbb75bd9"
version = "1.0.3"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "ArrayInterfaceCore", "ArrayInterfaceOffsetArrays", "ArrayInterfaceStaticArrays", "CPUSummary", "ChainRulesCore", "CloseOpenIntervals", "DocStringExtensions", "ForwardDiff", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "SIMDDualNumbers", "SIMDTypes", "SLEEFPirates", "SnoopPrecompile", "SpecialFunctions", "Static", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "155132d68bc33c826dbdeb452c5d0a79e2d0e586"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.146"

[[deps.Luxor]]
deps = ["Base64", "Cairo", "Colors", "Dates", "FFMPEG", "FileIO", "Juno", "LaTeXStrings", "Random", "Requires", "Rsvg", "SnoopPrecompile"]
git-tree-sha1 = "be7fc67bace176a51c94fb653dfdc1df26ca6be5"
uuid = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
version = "3.6.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "2ce8695e1e699b68702c03402672a69f54b8aca9"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.2.0+0"

[[deps.MLStyle]]
git-tree-sha1 = "060ef7956fef2dc06b0e63b294f7dbfbcbdc7ea2"
uuid = "d8e11817-5142-5d16-987a-aa16d5891078"
version = "0.4.16"

[[deps.MLUtils]]
deps = ["ChainRulesCore", "DataAPI", "DelimitedFiles", "FLoops", "FoldsThreads", "NNlib", "Random", "ShowCases", "SimpleTraits", "Statistics", "StatsBase", "Tables", "Transducers"]
git-tree-sha1 = "82c1104919d664ab1024663ad851701415300c5f"
uuid = "f1d291b0-491e-4a28-83b9-f70985020b54"
version = "0.3.1"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[deps.MarchingCubes]]
deps = ["SnoopPrecompile", "StaticArrays"]
git-tree-sha1 = "ffc66942498a5f0d02b9e7b1b1af0f5873142cdc"
uuid = "299715c1-40a9-479a-aaf9-4a633d36f717"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MatrixEquations]]
deps = ["LinearAlgebra", "LinearMaps"]
git-tree-sha1 = "3b284e9c98f645232f9cf07d4118093801729d43"
uuid = "99c1a7ee-ab34-5fd5-8076-27c950a045f4"
version = "2.2.2"

[[deps.MatrixPencils]]
deps = ["LinearAlgebra", "Polynomials", "Random"]
git-tree-sha1 = "864ae9033dc44114b112ee88752263cdd6a20f68"
uuid = "48965c70-4690-11ea-1f13-43a2532b2fa8"
version = "1.7.4"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measurements]]
deps = ["Calculus", "LinearAlgebra", "Printf", "RecipesBase", "Requires"]
git-tree-sha1 = "12950d646ce04fb2e89ba5bd890205882c3592d7"
uuid = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
version = "2.8.0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "2af69ff3c024d13bde52b34a2a7d6887d4e7b438"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.1"

[[deps.Metatheory]]
deps = ["AutoHashEquals", "DataStructures", "Dates", "DocStringExtensions", "Parameters", "Reexport", "TermInterface", "ThreadsX", "TimerOutputs"]
git-tree-sha1 = "0f39bc7f71abdff12ead4fc4a7d998fb2f3c171f"
uuid = "e9d8d322-4543-424a-9be4-0cc815abe26c"
version = "1.3.5"

[[deps.MicroCollections]]
deps = ["BangBang", "InitialValues", "Setfield"]
git-tree-sha1 = "4d5917a26ca33c66c8e5ca3247bd163624d35493"
uuid = "128add7d-3638-4c79-886c-908ea0c25c34"
version = "0.1.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.Mocking]]
deps = ["Compat", "ExprTools"]
git-tree-sha1 = "c272302b22479a24d1cf48c114ad702933414f80"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.7.5"

[[deps.ModelingToolkit]]
deps = ["AbstractTrees", "ArrayInterfaceCore", "Combinatorics", "Compat", "ConstructionBase", "DataStructures", "DiffEqBase", "DiffEqCallbacks", "DiffRules", "Distributed", "Distributions", "DocStringExtensions", "DomainSets", "ForwardDiff", "FunctionWrappersWrappers", "Graphs", "IfElse", "InteractiveUtils", "JuliaFormatter", "JumpProcesses", "LabelledArrays", "Latexify", "Libdl", "LinearAlgebra", "MacroTools", "NaNMath", "RecursiveArrayTools", "Reexport", "RuntimeGeneratedFunctions", "SciMLBase", "Serialization", "Setfield", "SimpleNonlinearSolve", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicIndexingInterface", "SymbolicUtils", "Symbolics", "UnPack", "Unitful"]
git-tree-sha1 = "86b5a6f7c95483eb8d98f7861e3f7c90113202b5"
uuid = "961ee093-0014-501f-94e3-6117800e7a78"
version = "8.40.0"

[[deps.MonteCarloMeasurements]]
deps = ["Distributed", "Distributions", "ForwardDiff", "LinearAlgebra", "MacroTools", "Random", "RecipesBase", "Requires", "SLEEFPirates", "StaticArrays", "Statistics", "StatsBase", "Test"]
git-tree-sha1 = "f2bf57ea9524d654e454a8a7c9a88ff7e91278d9"
uuid = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
version = "1.0.12"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.MuladdMacro]]
git-tree-sha1 = "cac9cc5499c25554cba55cd3c30543cff5ca4fab"
uuid = "46d2c3a1-f734-5fdb-9937-b9b9aeba4221"
version = "0.2.4"

[[deps.MultivariatePolynomials]]
deps = ["ChainRulesCore", "DataStructures", "LinearAlgebra", "MutableArithmetics"]
git-tree-sha1 = "393fc4d82a73c6fe0e2963dd7c882b09257be537"
uuid = "102ac46a-7ee4-5c85-9060-abc95bfdeaa3"
version = "0.4.6"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "aa532179d4a643d4bd9f328589ca01fa20a0d197"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.1.0"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "a0b464d183da839699f4c79e7606d9d186ec172c"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.3"

[[deps.NLsolve]]
deps = ["Distances", "LineSearches", "LinearAlgebra", "NLSolversBase", "Printf", "Reexport"]
git-tree-sha1 = "019f12e9a1a7880459d0173c182e6a99365d7ac1"
uuid = "2774e3e8-f4cf-5e23-947b-6d7e65073b56"
version = "4.5.1"

[[deps.NNlib]]
deps = ["Adapt", "ChainRulesCore", "LinearAlgebra", "Pkg", "Random", "Requires", "Statistics"]
git-tree-sha1 = "ea118791d386e0d52f3649f680642da6512c94af"
uuid = "872c559c-99b0-510c-b3b7-b6c96a88d5cd"
version = "0.8.14"

[[deps.NNlibCUDA]]
deps = ["Adapt", "CUDA", "LinearAlgebra", "NNlib", "Random", "Statistics"]
git-tree-sha1 = "538f90fc503946a3134a48e1026035fcf71248f4"
uuid = "a00861dc-f156-4864-bf3c-e6376f28a68d"
version = "0.2.5"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.NameResolution]]
deps = ["PrettyPrint"]
git-tree-sha1 = "1a0fa0e9613f46c9b8c11eee38ebb4f590013c5e"
uuid = "71a1bf82-56d0-4bbc-8a3c-48b961074391"
version = "0.1.5"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "2c3726ceb3388917602169bed973dbc97f1b51a8"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.13"

[[deps.Neighborhood]]
deps = ["Distances", "NearestNeighbors", "Random", "Test"]
git-tree-sha1 = "fdea60ca30d724e76cc3b3d90d7f9d29d3d5cab5"
uuid = "645ca80c-8b79-4109-87ea-e1f58159d116"
version = "0.2.4"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "5ae7ca23e13855b3aba94550f26146c01d259267"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.NonlinearSolve]]
deps = ["ArrayInterfaceCore", "DiffEqBase", "FiniteDiff", "ForwardDiff", "LinearAlgebra", "LinearSolve", "RecursiveArrayTools", "Reexport", "SciMLBase", "SimpleNonlinearSolve", "SnoopPrecompile", "SparseArrays", "SparseDiffTools", "StaticArraysCore", "UnPack"]
git-tree-sha1 = "7142ca5ab9bd7452cafb29f7d51f574a09d69052"
uuid = "8913a72c-1f9b-4ce2-8d82-65094dcecaec"
version = "1.1.1"

[[deps.Observables]]
git-tree-sha1 = "6862738f9796b3edc1c09d0890afce4eca9e7e93"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.4"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "f71d8950b724e9ff6110fc948dff5a329f901d64"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.8"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OneHotArrays]]
deps = ["Adapt", "ChainRulesCore", "Compat", "GPUArraysCore", "LinearAlgebra", "NNlib"]
git-tree-sha1 = "f511fca956ed9e70b80cd3417bb8c2dde4b68644"
uuid = "0b1bfda6-eb8a-41d2-88d8-f5af5cad476f"
version = "0.2.3"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "923319661e9a22712f24596ce81c54fc0366f304"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.1+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6e9dba33f9f2c44e08a020b0caf6903be540004"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.19+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Optim]]
deps = ["Compat", "FillArrays", "ForwardDiff", "LineSearches", "LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "PositiveFactorizations", "Printf", "SparseArrays", "StatsBase"]
git-tree-sha1 = "1903afc76b7d01719d9c30d3c7d501b61db96721"
uuid = "429524aa-4258-5aef-a3af-852621145aeb"
version = "1.7.4"

[[deps.Optimisers]]
deps = ["ChainRulesCore", "Functors", "LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "e657acef119cc0de2a8c0762666d3b64727b053b"
uuid = "3bd65402-5787-11e9-1adc-39752487f4e2"
version = "0.2.14"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.OrdinaryDiffEq]]
deps = ["Adapt", "ArrayInterface", "ArrayInterfaceCore", "ArrayInterfaceGPUArrays", "ArrayInterfaceStaticArrays", "ArrayInterfaceStaticArraysCore", "DataStructures", "DiffEqBase", "DocStringExtensions", "ExponentialUtilities", "FastBroadcast", "FastClosures", "FiniteDiff", "ForwardDiff", "FunctionWrappersWrappers", "LinearAlgebra", "LinearSolve", "Logging", "LoopVectorization", "MacroTools", "MuladdMacro", "NLsolve", "NonlinearSolve", "Polyester", "PreallocationTools", "Preferences", "RecursiveArrayTools", "Reexport", "SciMLBase", "SciMLNLSolve", "SimpleNonlinearSolve", "SnoopPrecompile", "SparseArrays", "SparseDiffTools", "StaticArrays", "UnPack"]
git-tree-sha1 = "e1563399318752a2df41d08ab1033a772bd0fa4b"
uuid = "1dea7af3-3e70-54e6-95c3-0bf5283fa5ed"
version = "6.36.2"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "cf494dca75a69712a72b80bc48f59dcf3dea63ec"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.16"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "f809158b27eba0c18c269cf2a2be6ed751d3e81d"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.17"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "03a7a85b76381a3d04c7a1656039197e70eda03d"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.11"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "84a314e3926ba9ec66ac097e3635e270986b0f10"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.50.9+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "6466e524967496866901a78fca3f2e9ea445a559"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.2"

[[deps.PenaltyFunctions]]
deps = ["InteractiveUtils", "LinearAlgebra", "RecipesBase"]
git-tree-sha1 = "4fb26eb6d41e0f8728772877ff159e45842fe8a0"
uuid = "06bb1623-fdd5-5ca2-a01c-88eae3ea319e"
version = "0.3.0"

[[deps.Pidfile]]
deps = ["FileWatching", "Test"]
git-tree-sha1 = "2d8aaf8ee10df53d0dfb9b8ee44ae7c04ced2b03"
uuid = "fa939f87-e72e-5be4-a000-7fc836dbe307"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlotlyLight]]
deps = ["Artifacts", "Cobweb", "DefaultApplication", "Downloads", "EasyConfig", "JSON3", "Random", "StructTypes"]
git-tree-sha1 = "ddc7784c88f66b1953d33d89f40ee7113cdf8368"
uuid = "ca7969ec-10b3-423e-8d99-40f33abb42bf"
version = "0.6.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eadad7b14cf046de6eb41f13c9275e5aa2711ab6"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.49"

[[deps.PoissonRandom]]
deps = ["Random"]
git-tree-sha1 = "45f9da1ceee5078267eb273d065e8aa2f2515790"
uuid = "e409e4f3-bfea-5376-8464-e040bb5c01ab"
version = "0.4.3"

[[deps.Polyester]]
deps = ["ArrayInterface", "BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "ManualMemory", "PolyesterWeave", "Requires", "Static", "StrideArraysCore", "ThreadingUtilities"]
git-tree-sha1 = "a5071cd52fc3fc0a960b825ddeb64e352fdf41e1"
uuid = "f517fe37-dbe3-4b94-8317-1923a5111588"
version = "0.6.20"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "43883d15c7cf16f340b9367c645cf88372f55641"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.1.13"

[[deps.Polynomials]]
deps = ["Intervals", "LinearAlgebra", "MutableArithmetics", "RecipesBase"]
git-tree-sha1 = "a1f7f4e41404bed760213ca01d7f384319f717a5"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "2.0.25"

[[deps.PositiveFactorizations]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "17275485f373e6673f7e7f97051f703ed5b15b20"
uuid = "85a6dd25-e78a-55b7-8502-1745935b8125"
version = "0.2.4"

[[deps.PreallocationTools]]
deps = ["Adapt", "ArrayInterfaceCore", "ForwardDiff"]
git-tree-sha1 = "758f3283aba57c53960c8e1900b4c724bf24ba74"
uuid = "d236fae5-4411-538c-8e31-a6e3d9e00b46"
version = "0.4.8"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyPrint]]
git-tree-sha1 = "632eb4abab3449ab30c5e1afaa874f0b98b586e4"
uuid = "8162dcfd-2161-5ef2-ae6c-7681170c5f98"
version = "0.2.0"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "311a2aa90a64076ea0fac2ad7492e914e6feeb81"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.ProgressLogging]]
deps = ["Logging", "SHA", "UUIDs"]
git-tree-sha1 = "80d919dee55b9c50e8d9e2da5eeafff3fe58b539"
uuid = "33c8b6b6-d38a-422a-b730-caa89a2f386c"
version = "0.1.4"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "97aa253e65b784fd13e83774cadc95b38011d734"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.6.0"

[[deps.QuasiMonteCarlo]]
deps = ["Distributions", "LatinHypercubeSampling", "LatticeRules", "LinearAlgebra", "Primes", "Random", "Sobol", "StatsBase"]
git-tree-sha1 = "b10f1a5345f14f6431712661925ae2d8c02780ee"
uuid = "8a4e6c94-4038-4cdc-81c3-7e6ffdb2a71b"
version = "0.2.19"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "a3c34ce146e39c9e313196bb853894c133f3a555"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.3"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Random123]]
deps = ["Random", "RandomNumbers"]
git-tree-sha1 = "7a1a306b72cfa60634f03a911405f4e64d1b718b"
uuid = "74087812-796a-5b5d-8853-05524746bad3"
version = "1.6.0"

[[deps.RandomExtensions]]
deps = ["Random", "SparseArrays"]
git-tree-sha1 = "062986376ce6d394b23d5d90f01d81426113a3c9"
uuid = "fb686558-2515-59ef-acaa-46db3789a887"
version = "0.4.3"

[[deps.RandomNumbers]]
deps = ["Random", "Requires"]
git-tree-sha1 = "043da614cc7e95c703498a491e2c21f58a2b8111"
uuid = "e6cf234a-135c-5ec9-84dd-332b85af5143"
version = "1.5.3"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.Reactive]]
deps = ["DataStructures", "Distributed", "Test"]
git-tree-sha1 = "5862d915387ebb954016f50a88e34f79a9e5fcd2"
uuid = "a223df75-4e93-5b7c-acf9-bdd599c0f4de"
version = "0.8.3"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "18c35ed630d7229c5584b945641a73ca83fb5213"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.2"

[[deps.RecurrenceAnalysis]]
deps = ["DelayEmbeddings", "DelimitedFiles", "Distances", "Graphs", "LinearAlgebra", "Random", "SparseArrays", "StaticArrays", "Statistics", "UnicodePlots"]
git-tree-sha1 = "6ef236edbec1e6e48ef64d2bb41e571267213f3a"
uuid = "639c3291-70d9-5ea2-8c5b-839eba1ee399"
version = "1.8.1"

[[deps.RecursiveArrayTools]]
deps = ["Adapt", "ArrayInterfaceCore", "ArrayInterfaceStaticArraysCore", "ChainRulesCore", "DocStringExtensions", "FillArrays", "GPUArraysCore", "IteratorInterfaceExtensions", "LinearAlgebra", "RecipesBase", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface", "Tables", "ZygoteRules"]
git-tree-sha1 = "66e6a85fd5469429a3ac30de1bd491e48a6bac00"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "2.34.1"

[[deps.RecursiveFactorization]]
deps = ["LinearAlgebra", "LoopVectorization", "Polyester", "SnoopPrecompile", "StrideArraysCore", "TriangularSolve"]
git-tree-sha1 = "2979cbb21580760431d2afb9b8f0f522899542f7"
uuid = "f2c3362d-daeb-58d1-803e-2bc74f2840b4"
version = "0.2.13"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Referenceables]]
deps = ["Adapt"]
git-tree-sha1 = "e681d3bfa49cd46c3c161505caddf20f0e62aaa9"
uuid = "42d2dcc6-99eb-4e98-b66c-637b7d73030e"
version = "0.1.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.RegularizationTools]]
deps = ["Calculus", "Lazy", "LeastSquaresOptim", "LinearAlgebra", "MLStyle", "Memoize", "Optim", "Random", "Underscores"]
git-tree-sha1 = "d445316cca15281a4b36b63c520123baa256a545"
uuid = "29dad682-9a27-4bc3-9c72-016788665182"
version = "0.6.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.ResettableStacks]]
deps = ["StaticArrays"]
git-tree-sha1 = "256eeeec186fa7f26f2801732774ccf277f05db9"
uuid = "ae5879a3-cd67-5da8-be7f-38c6eb64a37b"
version = "1.1.1"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.Roots]]
deps = ["ChainRulesCore", "CommonSolve", "Printf", "Setfield"]
git-tree-sha1 = "a3db467ce768343235032a1ca0830fc64158dadf"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "2.0.8"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "9480500060044fd25a1c341da53f34df7443c2f2"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.3.4"

[[deps.RoundingEmulator]]
git-tree-sha1 = "40b9edad2e5287e05bd413a38f61a8ff55b9557b"
uuid = "5eaf0fd0-dfba-4ccb-bf02-d820a40db705"
version = "0.2.1"

[[deps.RoundingIntegers]]
git-tree-sha1 = "99acd97f396ea71a5be06ba6de5c9defe188a778"
uuid = "d5f540fe-1c90-5db3-b776-2e2f362d9394"
version = "1.1.0"

[[deps.Rsvg]]
deps = ["Cairo", "Glib_jll", "Librsvg_jll"]
git-tree-sha1 = "3d3dc66eb46568fb3a5259034bfc752a0eb0c686"
uuid = "c4c386cf-5103-5370-be45-f3a111cca3b8"
version = "1.0.0"

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "SHA", "Serialization"]
git-tree-sha1 = "50314d2ef65fce648975a8e80ae6d8409ebbf835"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.5"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMDDualNumbers]]
deps = ["ForwardDiff", "IfElse", "SLEEFPirates", "VectorizationBase"]
git-tree-sha1 = "dd4195d308df24f33fb10dde7c22103ba88887fa"
uuid = "3cdde19b-5bb0-4aaf-8931-af3e248e098b"
version = "0.1.1"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "c8679919df2d3c71f74451321f1efea6433536cc"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.37"

[[deps.SciMLBase]]
deps = ["ArrayInterfaceCore", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "Markdown", "Preferences", "RecipesBase", "RecursiveArrayTools", "RuntimeGeneratedFunctions", "StaticArraysCore", "Statistics", "Tables"]
git-tree-sha1 = "fe89a8113ea445bcff9ee570077830674babb534"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "1.81.0"

[[deps.SciMLNLSolve]]
deps = ["LineSearches", "NLsolve", "Reexport", "SciMLBase"]
git-tree-sha1 = "b35d1f5d8afeee44e24915bb767e34fae867502f"
uuid = "e9a6253c-8580-4d32-9898-8661bb511710"
version = "0.1.1"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SetRounding]]
git-tree-sha1 = "d7a25e439d07a17b7cdf97eecee504c50fedf5f6"
uuid = "3cc68bcd-71a2-5612-b932-767ffbe40ab0"
version = "0.2.1"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.ShiftedArrays]]
git-tree-sha1 = "503688b59397b3307443af35cd953a13e8005c16"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "2.0.0"

[[deps.ShowCases]]
git-tree-sha1 = "7f534ad62ab2bd48591bdeac81994ea8c445e4a5"
uuid = "605ecd9f-84a6-4c9e-81e2-4798472b76a3"
version = "0.1.0"

[[deps.SimpleDiffEq]]
deps = ["DiffEqBase", "LinearAlgebra", "MuladdMacro", "Parameters", "RecursiveArrayTools", "Reexport", "StaticArrays"]
git-tree-sha1 = "736e6abb40125e753c7ea407d3c15eba13b803ed"
uuid = "05bca326-078c-5bf0-a5bf-ce7c7982d7fd"
version = "1.8.0"

[[deps.SimpleNonlinearSolve]]
deps = ["ArrayInterfaceCore", "FiniteDiff", "ForwardDiff", "Reexport", "SciMLBase", "SnoopPrecompile", "StaticArraysCore"]
git-tree-sha1 = "fc4b9f81a033cf6879c91bb7f5b3ff59008c7dd2"
uuid = "727e6d20-b764-4bd8-a329-72de5adea6c7"
version = "0.1.4"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays", "Test"]
git-tree-sha1 = "a6f404cc44d3d3b28c793ec0eb59af709d827e4e"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.2.1"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.Sobol]]
deps = ["DelimitedFiles", "Random"]
git-tree-sha1 = "5a74ac22a9daef23705f010f72c81d6925b19df8"
uuid = "ed01d8cd-4d21-5b2a-85b4-cc3bdc58bad4"
version = "1.5.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SparseDiffTools]]
deps = ["Adapt", "ArrayInterfaceCore", "ArrayInterfaceStaticArrays", "Compat", "DataStructures", "FiniteDiff", "ForwardDiff", "Graphs", "LinearAlgebra", "Requires", "SparseArrays", "StaticArrays", "VertexSafeGraphs"]
git-tree-sha1 = "4245283bee733122a9cb4545748d64e0c63337c0"
uuid = "47a9eef4-7e08-11e9-0b38-333d64bd3804"
version = "1.30.0"

[[deps.Sparspak]]
deps = ["Libdl", "LinearAlgebra", "Logging", "OffsetArrays", "Printf", "SparseArrays", "Test"]
git-tree-sha1 = "2d8eee38ff44389ffcd26ef39b289c2db786f6e5"
uuid = "e56a9233-b9d6-4f03-8d0f-1825330902ac"
version = "0.3.3"

[[deps.SpatialIndexing]]
git-tree-sha1 = "fb7041e6bd266266fa7cdeb80427579e55275e4f"
uuid = "d4ead438-fe20-5cc5-a293-4fd39a41b74c"
version = "0.1.3"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.SplittablesBase]]
deps = ["Setfield", "Test"]
git-tree-sha1 = "e08a62abc517eb79667d0a29dc08a3b589516bb5"
uuid = "171d559e-b47b-412a-8079-5efa626c420e"
version = "0.1.15"

[[deps.StableRNGs]]
deps = ["Random", "Test"]
git-tree-sha1 = "3be7d49667040add7ee151fefaf1f8c04c8c8276"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.0"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "c35b107b61e7f34fa3f124026f2a9be97dea9e1c"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.8.3"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "6954a456979f23d05085727adb17c4551c19ecd1"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.12"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "ab6083f09b3e617e34a956b43e9d51b824206932"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.1.1"

[[deps.StatsModels]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Printf", "REPL", "ShiftedArrays", "SparseArrays", "StatsBase", "StatsFuns", "Tables"]
git-tree-sha1 = "a5e15f27abd2692ccb61a99e0854dfb7d48017db"
uuid = "3eaba693-59b7-5ba5-a881-562e759f1c8d"
version = "0.6.33"

[[deps.SteadyStateDiffEq]]
deps = ["DiffEqBase", "DiffEqCallbacks", "LinearAlgebra", "NLsolve", "Reexport", "SciMLBase"]
git-tree-sha1 = "32d8ad240e065b5c86088c759670cb6bcc96e45a"
uuid = "9672c7b4-1e72-59bd-8a11-6ac3964bc41f"
version = "1.11.0"

[[deps.StochasticDiffEq]]
deps = ["Adapt", "ArrayInterface", "DataStructures", "DiffEqBase", "DiffEqNoiseProcess", "DocStringExtensions", "FillArrays", "FiniteDiff", "ForwardDiff", "JumpProcesses", "LevyArea", "LinearAlgebra", "Logging", "MuladdMacro", "NLsolve", "OrdinaryDiffEq", "Random", "RandomNumbers", "RecursiveArrayTools", "Reexport", "SciMLBase", "SparseArrays", "SparseDiffTools", "StaticArrays", "UnPack"]
git-tree-sha1 = "c35d43a21e91fd53ebe31bd6a3d81745e1c8fca0"
uuid = "789caeaf-c7a9-5a7d-9973-96adeb23e2a0"
version = "6.57.4"

[[deps.StrideArraysCore]]
deps = ["ArrayInterface", "CloseOpenIntervals", "IfElse", "LayoutPointers", "ManualMemory", "SIMDTypes", "Static", "ThreadingUtilities"]
git-tree-sha1 = "70b6ee0e5cc1745a28dd9ba040b8e5ee28fffc69"
uuid = "7792a7ef-975c-4747-a70f-980b88e8d1da"
version = "0.4.5"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "GPUArraysCore", "StaticArraysCore", "Tables"]
git-tree-sha1 = "b03a3b745aa49b566f128977a7dd1be8711c5e71"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.14"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "ca4bccb03acf9faaf4137a9abc1881ed1841aa70"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.10.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+0"

[[deps.Sundials]]
deps = ["CEnum", "DataStructures", "DiffEqBase", "Libdl", "LinearAlgebra", "Logging", "Reexport", "SciMLBase", "SnoopPrecompile", "SparseArrays", "Sundials_jll"]
git-tree-sha1 = "3f8c27118d25ac5cfd36ec382c9c3a834c4d91ad"
uuid = "c3572dad-4567-51f8-b174-8c6c989267f4"
version = "4.11.4"

[[deps.Sundials_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "OpenBLAS_jll", "Pkg", "SuiteSparse_jll"]
git-tree-sha1 = "04777432d74ec5bc91ca047c9e0e0fd7f81acdb6"
uuid = "fb77eaff-e24c-56d4-86b1-d163f2edb164"
version = "5.2.1+0"

[[deps.Surrogates]]
deps = ["Distributions", "ExtendableSparse", "GLM", "IterativeSolvers", "LinearAlgebra", "QuasiMonteCarlo", "SparseArrays", "Statistics", "Zygote"]
git-tree-sha1 = "89fba32583335648b65b879b49cd9ed08ff17026"
uuid = "6fc51010-71bc-11e9-0e15-a3fcc6593c49"
version = "6.5.1"

[[deps.SymbolicIndexingInterface]]
deps = ["DocStringExtensions"]
git-tree-sha1 = "6b764c160547240d868be4e961a5037f47ad7379"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.2.1"

[[deps.SymbolicUtils]]
deps = ["AbstractTrees", "Bijections", "ChainRulesCore", "Combinatorics", "ConstructionBase", "DataStructures", "DocStringExtensions", "DynamicPolynomials", "IfElse", "LabelledArrays", "LinearAlgebra", "Metatheory", "MultivariatePolynomials", "NaNMath", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "TermInterface", "TimerOutputs"]
git-tree-sha1 = "027b43d312f6d52187bb16c2d4f0588ddb8c4bb2"
uuid = "d1185830-fcd6-423d-90d6-eec64667417b"
version = "0.19.11"

[[deps.Symbolics]]
deps = ["ArrayInterfaceCore", "ConstructionBase", "DataStructures", "DiffRules", "Distributions", "DocStringExtensions", "DomainSets", "Groebner", "IfElse", "LaTeXStrings", "LambertW", "Latexify", "Libdl", "LinearAlgebra", "MacroTools", "Markdown", "Metatheory", "NaNMath", "RecipesBase", "Reexport", "Requires", "RuntimeGeneratedFunctions", "SciMLBase", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicUtils", "TermInterface", "TreeViews"]
git-tree-sha1 = "111fbf43883d95989577133aeeb889f2040d0aea"
uuid = "0c5d862f-8b57-4792-8d23-62f2024744c7"
version = "4.14.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "c79322d36826aa2f4fd8ecfa96ddb47b174ac78d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.TermInterface]]
git-tree-sha1 = "7aa601f12708243987b88d1b453541a75e3d8c7a"
uuid = "8ea1fca8-c5ef-4a55-8b96-4e9afe9c9a3c"
version = "0.2.3"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "f8629df51cab659d70d2e5618a430b4d3f37f2c3"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.0"

[[deps.ThreadsX]]
deps = ["ArgCheck", "BangBang", "ConstructionBase", "InitialValues", "MicroCollections", "Referenceables", "Setfield", "SplittablesBase", "Transducers"]
git-tree-sha1 = "34e6bcf36b9ed5d56489600cf9f3c16843fa2aa2"
uuid = "ac1d9e8a-700a-412c-b207-f0111f4b6c0d"
version = "0.1.11"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "7e6b0e3e571be0b4dd4d2a9a3a83b65c04351ccc"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.3"

[[deps.TiledIteration]]
deps = ["OffsetArrays"]
git-tree-sha1 = "5683455224ba92ef59db72d10690690f4a8dc297"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.3.1"

[[deps.TimeZones]]
deps = ["Dates", "Downloads", "InlineStrings", "LazyArtifacts", "Mocking", "Printf", "RecipesBase", "Scratch", "Unicode"]
git-tree-sha1 = "a92ec4466fc6e3dd704e2668b5e7f24add36d242"
uuid = "f269a46b-ccf7-5d73-abea-4c690281aa53"
version = "1.9.1"

[[deps.TimerOutputs]]
deps = ["ExprTools", "Printf"]
git-tree-sha1 = "f2fd3f288dfc6f507b0c3a2eb3bac009251e548b"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "0.5.22"

[[deps.Tokenize]]
git-tree-sha1 = "90538bf898832b6ebd900fa40f223e695970e3a5"
uuid = "0796e94c-ce3b-5d07-9a54-7f471281c624"
version = "0.5.25"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "e4bdc63f5c6d62e80eb1c0043fcc0360d5950ff7"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.10"

[[deps.Transducers]]
deps = ["Adapt", "ArgCheck", "BangBang", "Baselet", "CompositionsBase", "DefineSingletons", "Distributed", "InitialValues", "Logging", "Markdown", "MicroCollections", "Requires", "Setfield", "SplittablesBase", "Tables"]
git-tree-sha1 = "c42fa452a60f022e9e087823b47e5a5f8adc53d5"
uuid = "28d57a85-8fef-5791-bfe6-a80928e7c999"
version = "0.4.75"

[[deps.TreeViews]]
deps = ["Test"]
git-tree-sha1 = "8d0d7a3fe2f30d6a7f833a5f19f7c7a5b396eae6"
uuid = "a2a6695c-b41b-5b7d-aed9-dbfdeacea5d7"
version = "0.3.0"

[[deps.TriangularSolve]]
deps = ["CloseOpenIntervals", "IfElse", "LayoutPointers", "LinearAlgebra", "LoopVectorization", "Polyester", "SnoopPrecompile", "Static", "VectorizationBase"]
git-tree-sha1 = "6cca884e0fe17916da63c62dc1bf5896ce5d723e"
uuid = "d5829a12-d9aa-46ab-831f-fb7c9ab06edf"
version = "0.1.17"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "ac00576f90d8a259f2c9d823e91d1de3fd44d348"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Underscores]]
git-tree-sha1 = "6e6de5a5e7116dcff8effc99f6f55230c61f6862"
uuid = "d9a01c3f-67ce-4d8c-9b55-35f6e4050bb1"
version = "3.0.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodePlots]]
deps = ["ColorTypes", "Contour", "Crayons", "Dates", "FileIO", "FreeTypeAbstraction", "LazyModules", "LinearAlgebra", "MarchingCubes", "NaNMath", "Printf", "SparseArrays", "StaticArrays", "StatsBase", "Unitful"]
git-tree-sha1 = "ae67ab0505b9453655f7d5ea65183a1cd1b3cfa0"
uuid = "b8865327-cd53-5732-bb35-84acbb429228"
version = "2.12.4"

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d670a70dd3cdbe1c1186f2f17c9a68a7ec24838c"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.12.2"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static"]
git-tree-sha1 = "6b1dc4fc039d273abc247eba675ac1299380e5d9"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.57"

[[deps.VertexSafeGraphs]]
deps = ["Graphs"]
git-tree-sha1 = "8351f8d73d7e880bfc042a8b6922684ebeafb35c"
uuid = "19fa3120-7c27-5ec5-8db8-b0b0aa330d6f"
version = "0.2.0"

[[deps.VideoIO]]
deps = ["ColorTypes", "Dates", "Downloads", "FFMPEG", "FileIO", "Glob", "ImageCore", "Libdl", "ProgressMeter", "Requires"]
git-tree-sha1 = "043e79b3a7a51bda2bf0350aade7eb2c369069c6"
uuid = "d6d074c3-1acf-5d4c-9a43-ef38773959a2"
version = "0.9.7"

[[deps.Wavelets]]
deps = ["DSP", "FFTW", "LinearAlgebra", "Reexport", "SpecialFunctions", "Statistics"]
git-tree-sha1 = "58f7491c21ab2b1d69368c7f7e8a6a93cbf8b7bf"
uuid = "29a6e085-ba6d-5f35-a997-948ac2efa89a"
version = "0.9.5"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.WebIO]]
deps = ["AssetRegistry", "Base64", "Distributed", "FunctionalCollections", "JSON", "Logging", "Observables", "Pkg", "Random", "Requires", "Sockets", "UUIDs", "WebSockets", "Widgets"]
git-tree-sha1 = "976d0738247f155d0dcd77607edea644f069e1e9"
uuid = "0f1e0344-ec1d-5b48-a673-e5cf874b6c29"
version = "0.8.20"

[[deps.WebSockets]]
deps = ["Base64", "Dates", "HTTP", "Logging", "Sockets"]
git-tree-sha1 = "f91a602e25fe6b89afc93cf02a4ae18ee9384ce3"
uuid = "104b5d7c-a370-577a-8038-80a2059c5097"
version = "1.5.9"

[[deps.Widgets]]
deps = ["Colors", "Dates", "Observables", "OrderedCollections"]
git-tree-sha1 = "fcdae142c1cfc7d89de2d11e08721d0f2f86c98a"
uuid = "cc8bc4a8-27d6-5769-a93b-9d913e69aa62"
version = "0.6.6"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcomposite_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll"]
git-tree-sha1 = "7c688ca9c957837539bbe1c53629bb871025e423"
uuid = "3c9796d7-64a0-5134-86ad-79f8eb684845"
version = "0.4.5+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdamage_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll"]
git-tree-sha1 = "fe4ffb2024ba3eddc862c6e1d70e2b070cd1c2bf"
uuid = "0aeada51-83db-5f97-b67e-184615cfc6f6"
version = "1.1.5+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libXtst_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "Xorg_libXi_jll"]
git-tree-sha1 = "0c0a60851f44add2a64069ddf213e941c30ed93c"
uuid = "b6f176f1-7aea-5357-ad67-1d3e565ea1c6"
version = "1.2.3+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.Zygote]]
deps = ["AbstractFFTs", "ChainRules", "ChainRulesCore", "DiffRules", "Distributed", "FillArrays", "ForwardDiff", "GPUArrays", "GPUArraysCore", "IRTools", "InteractiveUtils", "LinearAlgebra", "LogExpFunctions", "MacroTools", "NaNMath", "Random", "Requires", "SparseArrays", "SpecialFunctions", "Statistics", "ZygoteRules"]
git-tree-sha1 = "a6f1287943ac05fae56fa06049d1a7846dfbc65f"
uuid = "e88e6eb3-aa80-5325-afca-941959d7151f"
version = "0.6.51"

[[deps.ZygoteRules]]
deps = ["MacroTools"]
git-tree-sha1 = "8c1a8e4dfacb1fd631745552c8db35d0deb09ea0"
uuid = "700de1a5-db45-46bc-99cf-38207098b444"
version = "0.2.2"

[[deps.adwaita_icon_theme_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "hicolor_icon_theme_jll"]
git-tree-sha1 = "37c9a36ccb876e02876c8a654f1b2e8c1b443a78"
uuid = "b437f822-2cd6-5e08-a15c-8bac984d38ee"
version = "3.33.92+5"

[[deps.at_spi2_atk_jll]]
deps = ["ATK_jll", "Artifacts", "JLLWrappers", "Libdl", "Pkg", "XML2_jll", "Xorg_libX11_jll", "at_spi2_core_jll"]
git-tree-sha1 = "f16ae690aca4761f33d2cb338ee9899e541f5eae"
uuid = "de012916-1e3f-58c2-8f29-df3ef51d412d"
version = "2.34.1+4"

[[deps.at_spi2_core_jll]]
deps = ["Artifacts", "Dbus_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXtst_jll"]
git-tree-sha1 = "d2d540cd145f2b2933614649c029d222fe125188"
uuid = "0fc3237b-ac94-5853-b45c-d43d59a06200"
version = "2.34.0+4"

[[deps.gdk_pixbuf_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Xorg_libX11_jll", "libpng_jll"]
git-tree-sha1 = "e9190f9fb03f9c3b15b9fb0c380b0d57a3c8ea39"
uuid = "da03df04-f53b-5353-a52f-6a8b0620ced0"
version = "2.42.8+0"

[[deps.hicolor_icon_theme_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b458a6f6fc2b1a8ca74ed63852e4eaf43fb9f5ea"
uuid = "059c91fe-1bad-52ad-bddd-f7b78713c282"
version = "0.17.0+3"

[[deps.iso_codes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51559b9071db7e363047a34f658d495843ccd35c"
uuid = "bf975903-5238-5d20-8243-bc370bc1e7e5"
version = "4.11.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

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
# ╟─8cb4d629-489a-461a-b9ca-3492b434f15f
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
# ╟─433cf2d5-465f-45cc-a16d-cab455fb03fa
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
# ╠═9ba77432-a5e3-4f79-94da-f034a8976aff
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
# ╠═a21b4b2a-96f2-4168-96ca-0666055975c7
# ╠═40676685-a013-4876-9d51-cbf83461ce75
# ╠═9fa4a109-33ac-42d6-8ebe-ba77f1c2b0eb
# ╠═7bdffbfd-b9aa-42b0-b663-c15e09235c9b
# ╠═6c92195b-6017-407c-becb-aaf03ebdd88c
# ╠═8e199596-c642-4d13-92b6-e72e64d49518
# ╠═48be1803-9ad4-4180-8825-b24a1e43bfc6
# ╠═03915951-c40f-4814-a99c-fbca03edaaba
# ╠═0b56d185-2767-43f1-90bb-0bc31c78f64a
# ╠═635f3ab7-97a0-47c8-ad28-bde405f64612
# ╠═0a510171-a1ae-4a20-8704-775f498ecaa7
# ╠═fa90b940-0e77-4b51-a7a9-e1be0c7fb791
# ╠═9989439d-04c6-418b-80c1-cf9d60ca9b0d
# ╠═4c1df659-29f1-431e-91d7-afef6defbab1
# ╠═c7676d9b-ff93-483e-9963-a69be391dbf0
# ╠═6e5659c6-cd5f-4f1b-8243-78f3e04a8dab
# ╠═20f1c638-5cec-11ec-2a1c-899c59354ba8
# ╠═fb0de123-da02-4982-a489-95fa9c87868a
# ╠═81f19bcf-4099-4b70-abc6-f204f4a6b7ee
# ╠═20fbf450-5de2-4685-943b-51d6ecb26fc6
# ╠═f2beb5c7-0cc9-4f73-8086-f9784c8bf86f
# ╠═7068c916-d48a-485b-9d2a-34e0c6e71451
# ╠═f071ac10-fe88-4af1-baa2-2d30a0a3af76
# ╠═0db7c33a-db7a-4c2f-bae2-c54d6e68435e
# ╠═5356a88f-f2c8-43f6-ad6d-1a8ebe42928d
# ╠═a34a4b59-5da7-413a-95a8-47bf8cbf338d
# ╠═a81168cd-eb9c-47d9-bdc3-bd2a2566a273
# ╠═f7af0b08-66f1-4b3f-aca5-2291f8d18306
# ╠═3844323c-8579-409c-a7bd-5b423b8c610b
# ╠═42043350-3ffd-4186-9bc1-382fd88d080c
# ╠═7905f3bd-7c91-448d-952e-06e18c5761ae
# ╠═1a241b91-9da2-4f89-85de-1e8e8f3b8dc4
# ╠═5ba902c1-f88e-4881-a204-60ce5fd7d80b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
