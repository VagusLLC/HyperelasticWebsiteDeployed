export NoDamage
export DamageRule

"""
NoDamage

Model for no damage occuring in the material
"""
struct NoDamage <: AbstractDamageModel end

DamageRule(::NoDamage, γ̇, p_damage, p_material) = p_material
