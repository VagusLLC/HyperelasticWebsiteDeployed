import Hyperelastics.AbstractHyperelasticModel
export GeneralParallelNetworkModel, ParallelNetworkBranch

"""
ParallelNetworkBranch

Constructor for network branches in the GeneralParallelNetwork Model
"""
struct ParallelNetworkBranch
    hyperelastic::AbstractHyperelasticModel
    flow::AbstractFlowModel
    damage::AbstractDamageModel
    ParallelNetworkBranch(hyperelastic;flow = NoFlow(), damage = NoDamage()) = new(hyperelastic, flow, damage)
end


"""
GeneralParallelNetworkModel

This model is a generalization of the Bergstrom-Boyce and the PolyUMod Three Network (Viscoplastic) models. This method supports all models available from Hyperelastics.jl and defaults to PowerFlow models for the flow behavior. Damage models are optional.

Model:

Parameters:
- network
    - hyperelastic
        - Contains the hyperelastic model parameters
    - flow
        - Contains the flow rule parameters
    - damage
        - Contains the damage rule parameters

Fields:
- networks::Dict{Symbol, NamedTuple}
- interpolant
- initial_state

> https://polymerfem.com/tnv-model/
> https://polymerfem.com/three-network-model/
> Bergstrom JS, Bischoff JE. An advanced thermomechanical constitutive model for UHMWPE. The International Journal of Structural Changes in Solids. 2010 Jan;2(1):31-9.
"""
struct GeneralParallelNetworkModel <: AbstractViscousModel
    networks::Dict{Symbol,ParallelNetworkBranch}
    network_names::Vector{Symbol}
    history::MaterialHistory
    Fv_history::Dict{Symbol, MaterialHistory}
    interpolant::Function
    prob::ODEProblem
end

ramp(x) = (x >= zero(x)) * x

function Ḟv_GNM(dλ_v, λ_v, p, t)
    (; network, network_parameters, flow_rule, flow_rule_parameters, damage_rule, damage_parameters, interpolant) = p
    λ = interpolant(t)
    λ_e = λ ./ λ_v
    σ = CauchyStressTensor(network, λ_e, network_parameters)
    σ_dev = σ .- (sum(σ) / 3)
    τ = norm(σ_dev)
    (τ > 0.0) ? (Nb = σ_dev / τ) : (Nb = zeros(size(λ_v)))
    γ̇ = FlowRule(flow_rule, λ_v, σ, flow_rule_parameters)
    if isnan(τ)
        γ̇ = 0.0
    end
    @. dλ_v = γ̇ * inv(λ_e) * Nb * λ
    return dλ_v
end

function GeneralParallelNetworkModel(
    networks::Dict{Symbol,ParallelNetworkBranch};
    interpolant=linear_interpolation,
    initial_state = MaterialHistory(ones(3), 0.0),
    initial_ISV_state = Dict(keys(networks).=>[MaterialHistory(ones(3), 0.0)]),
    )
    prob = ODEProblem(
        Ḟv_GNM,
        ones(3),
        (0.0, 1.0),
        NamedTuple()
    )
    network_names = collect(keys(networks))
    GeneralParallelNetworkModel(
        networks,
        network_names,
        initial_state,
        initial_ISV_state,
        interpolant,
        prob
    )
end

function Base.show(io::IO, ψ::GeneralParallelNetworkModel)
    Base.println(io, "Parallel Networks:")
    for k in ψ.network_names
        println(io, "Network $(k):")
        println(io, "\tHyperelastic: $(ψ.networks[k].hyperelastic)")
        println(io, "\tFlow Rule: $(ψ.networks[k].flow)")
        println(io, "\tDamage Rule: $(ψ.networks[k].damage)")
        println()
    end
end

function _BranchCauchyStressTensor(ψ, loading, p, network, network_values)
    λ_v = solve(
        ψ.prob,
        Tsit5(),
        save_everystep=false,
        u0=ψ.Fv_history[network].value[end],
        tspan=(ψ.history.time[end], loading.t),
        p=(
            network=network_values.hyperelastic,
            network_parameters=p.hyperelastic,
            flow_rule=network_values.flow,
            flow_rule_parameters=(network_values.flow isa NoFlow) ? () : (p.flow),
            damage_rule=network_values.damage,
            damage_parameters=(network_values.damage isa NoDamage) ? () : (p.damage),
            interpolant=ψ.interpolant([ψ.history.time; loading.t], [ψ.history.value[:]; [loading.F]])
        )
    ).u[end]
    λ_e = loading.F ./ λ_v
    σ = CauchyStressTensor(network_values.hyperelastic, λ_e, p.hyperelastic)
    return σ, λ_v
end

function _CauchyStressTensor(ψ::GeneralParallelNetworkModel, loading, p)
    # Update all Network Viscous Stretches
    f(kv) = _BranchCauchyStressTensor(ψ, loading, getindex(p, kv.first), kv.first, kv.second)
    networks = collect(pairs(ψ.networks))
    results = NamedTuple(getfield.(networks, :first) .=> map(f, networks))
    # return the stress and viscous stretches
    return results
end

function NonlinearContinua.CauchyStressTensor(ψ::GeneralParallelNetworkModel, loading, p)
    results = _CauchyStressTensor(ψ, loading, p)
    σ = sum(getindex.(values(results), 1))
    return σ
end

function NonlinearContinua.CauchyStressTensor!(ψ::GeneralParallelNetworkModel, loading, p)
    results = _CauchyStressTensor(ψ, loading, p)
    σ = sum(getindex.(values(results), 1))
    λv = map(x->x=>results[x][2], keys(results)) |> NamedTuple
    for k in ψ.network_names
        push!(ψ.Fv_history[k].value, getfield(λv, k))
        push!(ψ.Fv_history[k].time, loading.t)
    end
    push!(ψ.history.value, loading.F)
    push!(ψ.history.time, loading.t)
    return σ
end
