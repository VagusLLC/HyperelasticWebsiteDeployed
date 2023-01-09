module Viscoelastics

using Reexport
@reexport using Hyperelastics, InverseLangevinApproximations, NonlinearContinua
using Integrals, IntegralsCubature
using Interpolations
using Tullio, Accessors, StructArrays, ComponentArrays
using LinearAlgebra
using AbstractDifferentiation, ForwardDiff
using OrdinaryDiffEq
using NonlinearSolve, SciMLNLSolve, SciMLBase
using Optimization, LossFunctions, Statistics

export Xiang2019, Bergstrom1997
export Upadhyay2020, Upadhyay2020_3parameter, Upadhyay2020_1parameter

abstract type AbstractViscousModel <: NonlinearContinua.AbstractMaterialModel end
abstract type AbstractViscousData <: NonlinearContinua.AbstractMaterialTest end
abstract type AbstractFlowModel end
abstract type AbstractDamageModel end

include("flow_rules.jl")
include("damage_rules.jl")

include("xiang2019.jl")
include("bergstrom1997.jl")
# # include("reese2003.jl")
# include("miehe2005.jl")
# include("upadhyay2020.jl")
include("general_parallel_network.jl")
include("material_tests.jl")

end
