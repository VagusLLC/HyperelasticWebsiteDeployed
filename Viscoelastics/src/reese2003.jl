export Reese2003

"""
Reese 2003 [^1]


[^1]: Reese S. A micromechanically motivated material model for the thermo-viscoelastic material behaviour of rubber-like polymers. International Journal of Plasticity. 2003 Jul 1;19(7):909-40.
"""
struct Reese2003 <: AbstractViscousModel

end

function NonlinearContinua.CauchyStressTensor(ψ::Reese2003, history::MaterialHistory, p)

end

function NonlinearContinua.CauchyStressTensor!(ψ::Reese2003, history::MaterialHistory, p)

end
