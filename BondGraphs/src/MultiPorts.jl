## Create C- multiport
"""
**EXPERIMENTAL!!** Create a multiport C-element. Currently only works for completely symbolic models. Needs work to be integrated with the generate model function
"""
function add_C_multiport!(BG::AbstractBondGraph, elements, parameters, name; ฯi = (e, q, params, BG) -> [], ฯk = (e, q, params, BG) -> [])
    # Do the usual setup
    add_vertex!(BG.graph)
    node_index = nv(BG.graph)
    set_prop!(BG.graph, node_index, :name, name)
    for i โ eachindex(elements)
        add_edge!(BG.graph, BG.graph[name, :name], BG.graph[elements[i].first, :name])
    end

    D = Differential(BG.model.iv)
    # Sort Elements 
    ๐ช_1j = filter(x -> x.second == true, elements)
    j = length(๐ช_1j)
    @show j
    ๐_jp1n = filter(x -> x.second == false, elements)
    n = length(elements)
    @show n
    # Repack elements based on (7.20) & (7.21)
    elements = [๐ช_1j;๐_jp1n]
    # Create variable vectors 
    ๐ช = Symbolics.variables(:q, 1:length(elements), T = Symbolics.FnType)
    ๐ช = map(x -> ๐ช[x](BG.model.iv), eachindex(๐ช))
    ๐ = map(i -> BG[elements[i].first].e, eachindex(elements))
    # Create Derivative Relationships for displacement d/dt(qแตข) = fแตข
    deriv_eqns = map(i -> D(๐ช[i]) ~ ParentScope(BG[elements[i].first].f), eachindex(elements))
    ๐_1j = ฯi(๐[j + 1:n], ๐ช[1:j],  parameters, BG)
    e_eqns = map(i -> ParentScope(BG[elements[i].first].e) ~ ๐_1j[i], 1:j)

    ๐ช_jp1n = ฯk(๐[j + 1:n], ๐ช[1:j], parameters, BG)
    q_eqns = map(i -> ๐ช[j + i] ~ ๐ช_jp1n[i], 1:n - j)
    eqns = [deriv_eqns; e_eqns; q_eqns]
    eqns = convert(Vector{Equation}, eqns)
    subsystems = map(i -> BG[elements[i].first], eachindex(elements))
    sys = ODESystem(eqns, BG.model.iv, name = name)
    props = Dict(
            :type => :MPC,
            :sys => sys,
            :causality => false,
            :state_var => []
            )
    set_props!(BG.graph, node_index, props)
    nothing
end

## Create I-multiport
"""
**EXPERIMENTAL!!** Create a multiport I-element. Currently only works for completely symbolic models. Needs work to be integrated with the generate model function
"""
function add_I_multiport!(BG::AbstractBondGraph, elements, parameters, name; ฯi = (p, f, params) -> [], ฯk = (p, f, params) -> [])
    # Do the usual setup
    D = Differential(BG.model.iv)
    # Sort Elements 
    ๐ฉ_1j = filter(x -> x.second == false, elements)
    j = length(๐ฉ_1j)
    ๐_jp1n = filter(x -> x.second == true, elements)
    n = length(elements)
    # Repack elements based on (7.20) & (7.21)
    elements = [๐ฉ_1j;๐_jp1n]
    # Create variable vectors 
    ๐ฉ = Symbolics.variables(:p, 1:length(elements), T = Symbolics.FnType)
    ๐ฉ = map(x -> ๐ฉ[x](BG.model.iv), eachindex(๐ฉ))
    ๐ = map(i -> BG[elements[i].first].f, eachindex(elements))
    # Create Derivative Relationships for displacement d/dt(q_i) = f_i
    deriv_eqns = map(i -> D(๐ฉ[i]) ~ BG[elements[i].first].e, eachindex(elements))
    # Create Relationships for (7.20) e_i = ฯ_i(q_1j, e_jn, p)
    ๐_1j = ฯi(๐ฉ[1:j], ๐[j + 1:n], parameters)
    e_eqns = map(i -> BG[elements[i].first].f ~ ๐_1j[i], 1:j)
    ๐ฉ_jn = ฯk(๐ฉ[1:j], ๐[j + 1:n], parameters)
    q_eqns = map(i -> ๐ฉ[j + i] ~ ๐ฉ_jn[i], 1:n - j)
    return [deriv_eqns; e_eqns; q_eqns]
end
