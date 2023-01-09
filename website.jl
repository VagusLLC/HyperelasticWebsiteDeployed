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
	using PlutoUI, AbstractDifferentiation, ForwardDiff, CSV, ComponentArrays, DataFrames, Optimization, OptimizationOptimJL, InverseLangevinApproximations, LabelledArrays, CairoMakie, MakiePublication, HypertextLiteral
end

# ╔═╡ 2d189645-189f-4886-a6d5-5718a613798f
# ╠═╡ show_logs = false
using Hyperelastics

# ╔═╡ 73ab5774-dc3c-4759-92c4-7f7917c18cbf
HTML("""<center><h1> Hyperelastic Model <br> Fitting Toolbox</h1></center>
		<center><h2>Upload Test Data</h2></center>
		<center><p style="color:red;"><b>This tool is currently in test mode. Please provide any feedback to <i>contact@vagusllc.com</i></b></p></center>
		""")

# ╔═╡ cac1e660-c03b-420a-b9bc-b4d4712ae325
# md"""
# Select data: $(@bind data_type Select([:Custom => "User Provided"], default = :Custom))
# """

# ╔═╡ 692b1d0d-2353-4931-b289-490f74988811
md"""
Test Type: $(@bind test_type Select([:Uniaxial, :Biaxial]))

Upload Data $(@bind data FilePicker([MIME("text/csv")]))
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

# ╔═╡ 36cf277a-2683-43b2-a406-7eb8a0fcac07
const toc_js = toc -> @htl """
<script>
	
const indent = $(toc.indent)
const aside = $(toc.aside)
const title_text = $(toc.title)
const include_definitions = $(toc.include_definitions)
const tocNode = html`<nav class="plutoui-toc">
	<header>
	 <span class="toc-toggle open-toc"></span>
	 <span class="toc-toggle closed-toc"></span>
	 \${title_text}
	</header>
	<section></section>
</nav>`
tocNode.classList.toggle("aside", aside)
tocNode.classList.toggle("indent", indent)
const getParentCell = el => el.closest("pluto-cell")
const getHeaders = () => {
	const depth = Math.max(1, Math.min(6, $(toc.depth))) // should be in range 1:6
	const range = Array.from({length: depth}, (x, i) => i+1) // [1, ..., depth]
	
	const selector = [
		...(include_definitions ? [
			`pluto-notebook pluto-cell .pluto-docs-binding`, 
			`pluto-notebook pluto-cell assignee:not(:empty)`, 
		] : []),
		...range.map(i => `pluto-notebook pluto-cell h\${i}`)
	].join(",")
	return Array.from(document.querySelectorAll(selector)).filter(el => 
		// exclude headers inside of a pluto-docs-binding block
		!(el.nodeName.startsWith("H") && el.closest(".pluto-docs-binding"))
	)
}
const document_click_handler = (event) => {
	const path = (event.path || event.composedPath())
	const toc = path.find(elem => elem?.classList?.contains?.("toc-toggle"))
	if (toc) {
		event.stopImmediatePropagation()
		toc.closest(".plutoui-toc").classList.toggle("hide")
	}
}
document.addEventListener("click", document_click_handler)
const header_to_index_entry_map = new Map()
const currently_highlighted_set = new Set()
const last_toc_element_click_time = { current: 0 }
const intersection_callback = (ixs) => {
	let on_top = ixs.filter(ix => ix.intersectionRatio > 0 && ix.intersectionRect.y < ix.rootBounds.height / 2)
	if(on_top.length > 0){
		currently_highlighted_set.forEach(a => a.classList.remove("in-view"))
		currently_highlighted_set.clear()
		on_top.slice(0,1).forEach(i => {
			let div = header_to_index_entry_map.get(i.target)
			div.classList.add("in-view")
			currently_highlighted_set.add(div)
			
			/// scroll into view
			/*
			const toc_height = tocNode.offsetHeight
			const div_pos = div.offsetTop
			const div_height = div.offsetHeight
			const current_scroll = tocNode.scrollTop
			const header_height = tocNode.querySelector("header").offsetHeight
			
			const scroll_to_top = div_pos - header_height
			const scroll_to_bottom = div_pos + div_height - toc_height
			
			// if we set a scrollTop, then the browser will stop any currently ongoing smoothscroll animation. So let's only do this if you are not currently in a smoothscroll.
			if(Date.now() - last_toc_element_click_time.current >= 2000)
				if(current_scroll < scroll_to_bottom){
					tocNode.scrollTop = scroll_to_bottom
				} else if(current_scroll > scroll_to_top){
					tocNode.scrollTop = scroll_to_top
				}
			*/
		})
	}
}
let intersection_observer_1 = new IntersectionObserver(intersection_callback, {
	root: null, // i.e. the viewport
  	threshold: 1,
	rootMargin: "-15px", // slightly smaller than the viewport
	// delay: 100,
})
let intersection_observer_2 = new IntersectionObserver(intersection_callback, {
	root: null, // i.e. the viewport
  	threshold: 1,
	rootMargin: "15px", // slightly larger than the viewport
	// delay: 100,
})
const render = (elements) => {
	header_to_index_entry_map.clear()
	currently_highlighted_set.clear()
	intersection_observer_1.disconnect()
	intersection_observer_2.disconnect()
		let last_level = `H1`
	return html`\${elements.map(h => {
	const parent_cell = getParentCell(h)
		let [className, title_el] = h.matches(`.pluto-docs-binding`) ? ["pluto-docs-binding-el", h.firstElementChild] : [h.nodeName, h]
	const a = html`<a 
		class="\${className}" 
		title="\${title_el.innerText}"
		href="#\${parent_cell.id}"
	>\${title_el.innerHTML}</a>`
	/* a.onmouseover=()=>{
		parent_cell.firstElementChild.classList.add(
			'highlight-pluto-cell-shoulder'
		)
	}
	a.onmouseout=() => {
		parent_cell.firstElementChild.classList.remove(
			'highlight-pluto-cell-shoulder'
		)
	} */
		
		
	a.onclick=(e) => {
		e.preventDefault();
		last_toc_element_click_time.current = Date.now()
		h.scrollIntoView({
			behavior: 'smooth', 
			block: 'start'
		})
	}
	const row =  html`<div class="toc-row \${className} after-\${last_level}">\${a}</div>`
		intersection_observer_1.observe(title_el)
		intersection_observer_2.observe(title_el)
		header_to_index_entry_map.set(title_el, row)
	if(className.startsWith("H"))
		last_level = className
		
	return row
})}`
}
const invalidated = { current: false }
const updateCallback = () => {
	if (!invalidated.current) {
		tocNode.querySelector("section").replaceWith(
			html`<section>\${render(getHeaders())}</section>`
		)
	}
}
updateCallback()
setTimeout(updateCallback, 100)
setTimeout(updateCallback, 1000)
setTimeout(updateCallback, 5000)
const notebook = document.querySelector("pluto-notebook")
// We have a mutationobserver for each cell:
const mut_observers = {
	current: [],
}
const createCellObservers = () => {
	mut_observers.current.forEach((o) => o.disconnect())
	mut_observers.current = Array.from(notebook.querySelectorAll("pluto-cell")).map(el => {
		const o = new MutationObserver(updateCallback)
		o.observe(el, {attributeFilter: ["class"]})
		return o
	})
}
createCellObservers()
// And one for the notebook's child list, which updates our cell observers:
const notebookObserver = new MutationObserver(() => {
	updateCallback()
	createCellObservers()
})
notebookObserver.observe(notebook, {childList: true})
// And finally, an observer for the document.body classList, to make sure that the toc also works when it is loaded during notebook initialization
const bodyClassObserver = new MutationObserver(updateCallback)
bodyClassObserver.observe(document.body, {attributeFilter: ["class"]})
// Hide/show the ToC when the screen gets small
let m = matchMedia("(max-width: 2000px)")
let match_listener = () => 
	tocNode.classList.toggle("hide", m.matches)
match_listener()
m.addListener(match_listener)
invalidation.then(() => {
	invalidated.current = true
	intersection_observer_1.disconnect()
	intersection_observer_2.disconnect()
	notebookObserver.disconnect()
	bodyClassObserver.disconnect()
	mut_observers.current.forEach((o) => o.disconnect())
	document.removeEventListener("click", document_click_handler)
	m.removeListener(match_listener)
})
return tocNode
</script>
""";

# ╔═╡ 93e75cbf-946a-4244-a8ae-a54120169824
const toc_css = @htl """
<style>
@media not print {
.plutoui-toc {
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Cantarell, Helvetica, Arial, "Apple Color Emoji",
		"Segoe UI Emoji", "Segoe UI Symbol", system-ui, sans-serif;
	--main-bg-color: #fafafa;
	--pluto-output-color: hsl(0, 0%, 36%);
	--pluto-output-h-color: hsl(0, 0%, 21%);
	--sidebar-li-active-bg: rgb(235, 235, 235);
	--icon-filter: unset;
}
@media (prefers-color-scheme: dark) {
	.plutoui-toc {
		--main-bg-color: #303030;
		--pluto-output-color: hsl(0, 0%, 90%);
		--pluto-output-h-color: hsl(0, 0%, 97%);
		--sidebar-li-active-bg: rgb(82, 82, 82);
		--icon-filter: invert(1);
	}
}
.plutoui-toc.aside {
	color: var(--pluto-output-color);
	position: fixed;
	right: 1rem;
	top: 5rem;
	width: min(80vw, 300px);
	padding: 0.5rem;
	padding-top: 0em;
	/* border: 3px solid rgba(0, 0, 0, 0.15); */
	border-radius: 10px;
	/* box-shadow: 0 0 11px 0px #00000010; */
	max-height: calc(100vh - 5rem - 90px);
	overflow: auto;
	z-index: 40;
	background-color: var(--main-bg-color);
	transition: transform 300ms cubic-bezier(0.18, 0.89, 0.45, 1.12);
}
.plutoui-toc.aside.hide {
	transform: translateX(calc(100% - 28px));
}
.plutoui-toc.aside.hide section {
	display: none;
}
.plutoui-toc.aside.hide header {
	margin-bottom: 0em;
	padding-bottom: 0em;
	border-bottom: none;
}
}  /* End of Media print query */
.plutoui-toc.aside.hide .open-toc,
.plutoui-toc.aside:not(.hide) .closed-toc,
.plutoui-toc:not(.aside) .closed-toc {
	display: none;
}
@media (prefers-reduced-motion) {
  .plutoui-toc.aside {
	transition-duration: 0s;
  }
}
.toc-toggle {
	cursor: pointer;
    padding: 1em;
    margin: -1em;
    margin-right: -0.7em;
    line-height: 1em;
    display: flex;
}
.toc-toggle::before {
    content: "";
    display: inline-block;
    height: 1em;
    width: 1em;
    background-image: url("https://cdn.jsdelivr.net/gh/ionic-team/ionicons@5.5.1/src/svg/list-outline.svg");
	/* generated using https://dopiaza.org/tools/datauri/index.php */
    background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHRpdGxlPmlvbmljb25zLXY1LW88L3RpdGxlPjxsaW5lIHgxPSIxNjAiIHkxPSIxNDQiIHgyPSI0NDgiIHkyPSIxNDQiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDozMnB4Ii8+PGxpbmUgeDE9IjE2MCIgeTE9IjI1NiIgeDI9IjQ0OCIgeTI9IjI1NiIgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDtzdHJva2UtbGluZWNhcDpyb3VuZDtzdHJva2UtbGluZWpvaW46cm91bmQ7c3Ryb2tlLXdpZHRoOjMycHgiLz48bGluZSB4MT0iMTYwIiB5MT0iMzY4IiB4Mj0iNDQ4IiB5Mj0iMzY4IiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6MzJweCIvPjxjaXJjbGUgY3g9IjgwIiBjeT0iMTQ0IiByPSIxNiIgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDtzdHJva2UtbGluZWNhcDpyb3VuZDtzdHJva2UtbGluZWpvaW46cm91bmQ7c3Ryb2tlLXdpZHRoOjMycHgiLz48Y2lyY2xlIGN4PSI4MCIgY3k9IjI1NiIgcj0iMTYiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDozMnB4Ii8+PGNpcmNsZSBjeD0iODAiIGN5PSIzNjgiIHI9IjE2IiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6MzJweCIvPjwvc3ZnPg==");
    background-size: 1em;
	filter: var(--icon-filter);
}
.aside .toc-toggle.open-toc:hover::before {
    background-image: url("https://cdn.jsdelivr.net/gh/ionic-team/ionicons@5.5.1/src/svg/arrow-forward-outline.svg");
	/* generated using https://dopiaza.org/tools/datauri/index.php */
    background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHRpdGxlPmlvbmljb25zLXY1LWE8L3RpdGxlPjxwb2x5bGluZSBwb2ludHM9IjI2OCAxMTIgNDEyIDI1NiAyNjggNDAwIiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6NDhweCIvPjxsaW5lIHgxPSIzOTIiIHkxPSIyNTYiIHgyPSIxMDAiIHkyPSIyNTYiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDo0OHB4Ii8+PC9zdmc+");
}
.aside .toc-toggle.closed-toc:hover::before {
    background-image: url("https://cdn.jsdelivr.net/gh/ionic-team/ionicons@5.5.1/src/svg/arrow-back-outline.svg");
	/* generated using https://dopiaza.org/tools/datauri/index.php */
    background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHRpdGxlPmlvbmljb25zLXY1LWE8L3RpdGxlPjxwb2x5bGluZSBwb2ludHM9IjI0NCA0MDAgMTAwIDI1NiAyNDQgMTEyIiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6NDhweCIvPjxsaW5lIHgxPSIxMjAiIHkxPSIyNTYiIHgyPSI0MTIiIHkyPSIyNTYiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDo0OHB4Ii8+PC9zdmc+");
}
.plutoui-toc header {
	display: flex;
	align-items: center;
	gap: .3em;
	font-size: 1.5em;
	/* margin-top: -0.1em; */
	margin-bottom: 0.4em;
	padding: 0.5rem;
	margin-left: 0;
	margin-right: 0;
	font-weight: bold;
	border-bottom: 2px solid rgba(0, 0, 0, 0.15);
	position: sticky;
	top: 0px;
	background: var(--main-bg-color);
	z-index: 41;
}
.plutoui-toc.aside header {
	padding-left: 0;
	padding-right: 0;
}
.plutoui-toc section .toc-row {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	padding: .1em;
	border-radius: .2em;
}
.plutoui-toc section .toc-row.H1 {
	margin-top: 1em;
}
.plutoui-toc.aside section .toc-row.in-view {
	background: var(--sidebar-li-active-bg);
}
	
.highlight-pluto-cell-shoulder {
	background: rgba(0, 0, 0, 0.05);
	background-clip: padding-box;
}
.plutoui-toc section a {
	text-decoration: none;
	font-weight: normal;
	color: var(--pluto-output-color);
}
.plutoui-toc section a:hover {
	color: var(--pluto-output-h-color);
}
.plutoui-toc.indent section a.H1 {
	font-weight: 700;
	line-height: 1em;
}
.plutoui-toc.indent section .after-H2 a { padding-left: 10px; }
.plutoui-toc.indent section .after-H3 a { padding-left: 20px; }
.plutoui-toc.indent section .after-H4 a { padding-left: 30px; }
.plutoui-toc.indent section .after-H5 a { padding-left: 40px; }
.plutoui-toc.indent section .after-H6 a { padding-left: 50px; }
.plutoui-toc.indent section a.H1 { padding-left: 0px; }
.plutoui-toc.indent section a.H2 { padding-left: 10px; }
.plutoui-toc.indent section a.H3 { padding-left: 20px; }
.plutoui-toc.indent section a.H4 { padding-left: 30px; }
.plutoui-toc.indent section a.H5 { padding-left: 40px; }
.plutoui-toc.indent section a.H6 { padding-left: 50px; }
.plutoui-toc.indent section a.pluto-docs-binding-el,
.plutoui-toc.indent section a.ASSIGNEE
	{
	font-family: JuliaMono, monospace;
	font-size: .8em;
	/* background: black; */
	font-weight: 700;
    font-style: italic;
	color: var(--cm-var-color); /* this is stealing a variable from Pluto, but it's fine if that doesnt work */
}
.plutoui-toc.indent section a.pluto-docs-binding-el::before,
.plutoui-toc.indent section a.ASSIGNEE::before
	{
	content: "> ";
	opacity: .3;
}
</style>
""";

# ╔═╡ ea9f6a58-a5df-4a2e-aadd-5ff1107d8b55
begin
	Base.@kwdef struct TableOfContents_NEW
		title::AbstractString="Table of Contents"
		indent::Bool=true
		depth::Integer=3
		aside::Bool=true
		include_definitions::Bool=false
	end
	function Base.show(io::IO, m::MIME"text/html", toc::TableOfContents_NEW)
		Base.show(io, m, @htl("$(toc_js(toc))$(toc_css)"))
	end
end

# ╔═╡ 0dd8b7de-570d-41a7-b83d-d1bbe39c017e
TableOfContents_NEW()

# ╔═╡ d495c5e5-bf33-475c-a49a-5c9f8dc13789
set_theme!(MakiePublication.theme_web(width = 1000))

# ╔═╡ e0e7407d-fe60-4583-8060-3ba38c22c409
begin
	exclude = [:HorganMurphy, :KhiemItskov, :GeneralCompressible, :LogarithmicCompressible, :GeneralMooneyRivlin];
	ns = filter(x->x!=:citation, names(Hyperelastics))
	hyperelastic_models = filter(x -> typeof(getfield(Hyperelastics, x)) <: Union{DataType, UnionAll},ns)
	hyperelastic_models = filter(x -> !(getfield(Hyperelastics, x) <: Hyperelastics.AbstractDataDrivenHyperelasticModel) && (getfield(Hyperelastics, x) <: Hyperelastics.AbstractHyperelasticModel), hyperelastic_models)
	hyperelastic_models = filter(x -> !(x in exclude), hyperelastic_models)
	map(model->Hyperelastics.parameters(model()), Base.Fix1(getfield, Hyperelastics).( hyperelastic_models))
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
		ax1 = Makie.Axis(f[1, 1], xlabel = "λ₁ - Stretch", ylabel = "Stress")
		ax2 = Makie.Axis(f[1, 2], xlabel = "λ₂ - Stretch", ylabel = "Stress")
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

# ╔═╡ 6fe5cea7-6573-426f-875e-066a0ed0cfde

if @isdefined he_data
if !isnothing(he_data)
md"""Fit Model: $(@bind fit_model CheckBox(default = false))"""
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

# ╔═╡ 86f7e74f-c0a9-4561-85b9-f3ed6559facc
function ShearModulus(ψ, ps; adb = AD.ForwardDiffBackend())
	s(x) = AD.gradient(adb,x->StrainEnergyDensity(ψ, x, ps), x)[1][1]-AD.gradient(adb,x->StrainEnergyDensity(ψ, x, ps), x)[1][3]*x[3]
	AD.gradient(adb,y->s(y)[1], [1.0, 1.0, 1.0])[1][1]
end;

# ╔═╡ 8ea07dab-06dc-456d-9769-5e9c3980a777
ElasticModulus(ψ, ps) = ShearModulus(ψ, ps)*3;

# ╔═╡ bcf0c08c-cc7a-4785-a87b-2be47633eb85
function model_note(ψ::Gent)
	return (
	μ = "Small strain shear modulus",
	Jₘ = "Limiting Stretch Invariant"
	)
end;

# ╔═╡ c91bc6e2-d046-47fe-8e90-b000fcbf3b8a
function fit_parameters(he_data, p₀, model, parsed, fit_model)
	if !isnothing(he_data)
		if parsed && fit_model
			ψ = getfield(Hyperelastics, Symbol(model))()
			heprob = HyperelasticProblem(ψ, he_data, p₀)
			if !(isnothing(heprob))
			opt = getfield(OptimizationOptimJL, optimizer)()
			solution = solve(heprob, opt)
			sol = NamedTuple(solution.u)
			return sol
			end
		end
	end
end;

# ╔═╡ 1018d35f-42e9-4970-8a5f-f5cc6e951cbc
(@isdefined he_data) ? (sol = fit_parameters(he_data, p₀, model, parsed, fit_model);) : ();

# ╔═╡ 0fa152b1-462a-4f34-9753-13ef6ef63071
if @isdefined he_data
	if !isnothing(he_data)
		if !(isnothing(ps))
			if @isdefined sol
				if !(isnothing(sol))
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
end

# ╔═╡ 1345476c-ee08-4233-8506-0ebc94a2bec5
let
if @isdefined he_data
	if !isnothing(he_data)
		if parsed && fit_model
			if @isdefined sol
				if !(isnothing(sol))
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
						λ₁,Δs₁₃, 
						# color = MakiePublication.seaborn_muted()[2],
					)
					l12 = lines!(
						ax1,
						λ₁,Δs₂₃, 
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
						λ₂,	Δs₁₃, 
					)
					l22 = lines!(
						ax2,
						λ₂, Δs₂₃, 
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
end

# ╔═╡ 9441279c-49d9-4640-aca5-4576e6ee29ed
if @isdefined he_data
if !isnothing(he_data) && fit_model && @isdefined sol
	if parsed && !isnothing(he_data)
		if !(isnothing(sol))
		HTML("""
		<center><h2  style = "font-family:Archivo Black"> Other Values </h2></center>
		<p  style = "font-family:Archivo Black">
		Small Strain Shear Modulus: $(round(ShearModulus(getfield(Hyperelastics, Symbol(model))(), sol), digits = 3))
		<br>
		Small Strain Elastic Modulus: $(round(ElasticModulus(getfield(Hyperelastics, Symbol(model))(), sol), digits = 3))
		</p>
		""")
		end
	end
end
end

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
# ╟─6fe5cea7-6573-426f-875e-066a0ed0cfde
# ╟─08d775f2-94fc-4ca8-bcdd-e9535cfd129a
# ╟─1018d35f-42e9-4970-8a5f-f5cc6e951cbc
# ╟─0fa152b1-462a-4f34-9753-13ef6ef63071
# ╟─1345476c-ee08-4233-8506-0ebc94a2bec5
# ╟─9441279c-49d9-4640-aca5-4576e6ee29ed
# ╟─7196aa51-e86d-4f0e-ae40-cc6aa74aa237
# ╟─9e411ed3-0061-4831-b047-44c920959c83
# ╟─36cf277a-2683-43b2-a406-7eb8a0fcac07
# ╟─93e75cbf-946a-4244-a8ae-a54120169824
# ╟─ea9f6a58-a5df-4a2e-aadd-5ff1107d8b55
# ╟─e5a18d4c-14cd-11ed-36d5-69de0fd02830
# ╟─2d189645-189f-4886-a6d5-5718a613798f
# ╟─d495c5e5-bf33-475c-a49a-5c9f8dc13789
# ╟─e0e7407d-fe60-4583-8060-3ba38c22c409
# ╟─7998136a-de3d-42f9-9028-1172415c8b75
# ╟─12256359-1dca-4a71-a225-66994e2dfd66
# ╟─4d6f03c0-203a-4536-8ca2-c3dd77182ce6
# ╟─d0713eb0-fe75-4ea4-bf20-2d4e9b722da5
# ╟─86f7e74f-c0a9-4561-85b9-f3ed6559facc
# ╟─8ea07dab-06dc-456d-9769-5e9c3980a777
# ╟─bcf0c08c-cc7a-4785-a87b-2be47633eb85
# ╟─c91bc6e2-d046-47fe-8e90-b000fcbf3b8a
