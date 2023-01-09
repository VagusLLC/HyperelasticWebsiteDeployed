using Viscoelastics, Hyperelastics, NonlinearContinua
using LinearAlgebra
using ComponentArrays
using CairoMakie
## ---- Figure Setup ----
fig = Figure(font="CMU Serif")
ax = CairoMakie.Axis(
    fig[1, 1],
    # yticks=0.0:0.05:0.35,
    ylabel="Stress [MPa]",
    xlabel="Stretch",
    # palette=(color=ColorSchemes.tol_muted,),
)
# ylims!(ax, 0.0, 0.35)
# xlims!(ax, 1.0, 8.0)
# ---- Experimental Data ----
λ₁ = [
    1.0762, 1.0985, 1.1524, 1.2394, 1.2508, 1.359, 1.4018, 1.4891, 1.4894, 1.5324, 1.5856, 1.6948, 1.7058, 1.8016, 1.8679, 2.0284, 2.1055, 2.2031, 2.2767, 2.3433, 2.5034, 2.5814, 2.6781, 2.7517, 2.927, 2.9481, 3, 3.2051, 3.2181, 3.3483, 3.4426, 3.4449, 3.6292, 3.7342, 3.8446, 3.8777, 3.9825, 4.1254, 4.1801, 4.1877, 4.4144, 4.5583, 4.5683, 4.6412, 4.8572, 5.0111, 5.0554, 5.0733, 5.2677, 5.4445, 5.4946, 5.4974, 5.7107, 5.8013, 5.9082, 5.916, 6.1106, 6.1149, 6.2542, 6.3267, 6.3422, 6.5106, 6.6295, 6.6328, 6.6559, 6.8026, 6.9265, 6.9575, 6.9865, 7.1489, 7.2282, 7.2572, 7.3273, 7.4088, 7.445, 7.5388, 7.6419, 7.6689, 7.6835, 7.7989, 7.8264, 7.8354, 7.9075, 7.9894, 8.0092, 8.0268]
s0065 = [
    0.011549, 0.014853, 0.023098, 0.034165, 0.03508, 0.041634, 0.043783, 0.047846, 0.04786, 0.049608, 0.051473, 0.054414, 0.054669, 0.056754, 0.058141, 0.061071, 0.062146, 0.063396, 0.064424, 0.065524, 0.06826, 0.069267, 0.070326, 0.071131, 0.073398, 0.073703, 0.074484, 0.07784, 0.078047, 0.080092, 0.081675, 0.081715, 0.085096, 0.086951, 0.088679, 0.08917, 0.090785, 0.093456, 0.09448, 0.094623, 0.098458, 0.101376, 0.101595, 0.103257, 0.108538, 0.112365, 0.113411, 0.113819, 0.118138, 0.12295, 0.124381, 0.124462, 0.130625, 0.133432, 0.137067, 0.137351, 0.144559, 0.144699, 0.148916, 0.151284, 0.151842, 0.158975, 0.164262, 0.164421, 0.165564, 0.172916, 0.178655, 0.180131, 0.181569, 0.190705, 0.195565, 0.19743258, 0.202079, 0.207537, 0.20997, 0.216675, 0.22507, 0.227258, 0.228423, 0.237841, 0.240492, 0.241402, 0.248906, 0.25633, 0.258007, 0.259489]
s065 = [
    0.0203629, 0.0262088, 0.0290443, 0.04032, 0.041253, 0.050044, 0.053513, 0.060627, 0.060654, 0.063512, 0.066663, 0.07313, 0.073767, 0.078779, 0.081302, 0.085611, 0.087544, 0.090282, 0.09242, 0.094268, 0.09834, 0.100204, 0.102429, 0.104046, 0.107738, 0.108188, 0.109311, 0.113694, 0.113946, 0.116252, 0.118214, 0.118264, 0.122587, 0.125143, 0.127865, 0.128551, 0.130805, 0.134104, 0.135439, 0.135625, 0.141333, 0.144906, 0.145147, 0.146884, 0.151932, 0.155708, 0.156852, 0.157322, 0.162758, 0.16831, 0.170019, 0.170117, 0.178147, 0.181768, 0.185976, 0.186273, 0.193383, 0.19354, 0.198951, 0.202079, 0.20277, 0.210831, 0.217043, 0.217219, 0.218476, 0.22683, 0.234146, 0.235973, 0.237669, 0.24724, 0.252323, 0.254341, 0.259669, 0.266498, 0.269639, 0.277827, 0.286771, 0.28908, 0.290324, 0.300196, 0.302874, 0.303794, 0.311834, 0.321611, 0.324002, 0.326132]
s1613 = [
    0.020048, 0.023583, 0.031903, 0.043012, 0.044274, 0.055005, 0.058823, 0.065898, 0.065922, 0.068783, 0.071379, 0.075592, 0.076017, 0.07983, 0.082501, 0.08895, 0.091991, 0.095722, 0.098396, 0.100682, 0.105602, 0.107732, 0.11025, 0.1121, 0.116374, 0.11688, 0.118125, 0.123028, 0.123339, 0.126455, 0.128736, 0.128791, 0.133657, 0.136852, 0.140025, 0.140861, 0.143165, 0.146235, 0.14758, 0.147777, 0.154577, 0.159109, 0.159415, 0.161639, 0.168084, 0.172665, 0.173999, 0.174541, 0.180685, 0.186971, 0.188916, 0.189028, 0.197737, 0.201389, 0.205504, 0.2058, 0.213684, 0.213885, 0.221525, 0.225583, 0.226386, 0.234377, 0.239975, 0.240135, 0.241289, 0.249693, 0.257639, 0.259624, 0.261479, 0.272111, 0.277625, 0.279723, 0.285053, 0.291835, 0.295055, 0.303955, 0.314399, 0.317156, 0.318652, 0.330615, 0.333643, 0.334655, 0.343192, 0.353371, 0.355845, 0.358043]
scatter!(ax, λ₁, s0065, label="Experimental - 0.0065 1/s", font="CMU Serif")
scatter!(ax, λ₁, s065, label="Experimental - 0.065 1/s")
scatter!(ax, λ₁, s1613, label="Experimental - 0.1613 1/s")
current_figure()
# --- Viscoelastic Model Parameters
p = ComponentVector(
    ψH=(
        Gc=1.5e4,
        N=35.0,
        Ge=3.98e4
    ),
    ψV_cf=(
        Gc=1.28e4,
        N=54.0,
        Ge=6.36e4
    ),
    ψV_ef=(
        Gc=1.28e4,
        N=54.0,
        Ge=6.36e4
    ),
    τr=53.686,
    τd=96.76,
)
## ---- Determnine the stresses and plot
for q ∈ [0.0065, 0.065, 0.1613]
    model = Viscoelastics.Xiang2019(true, N=5)
    s = Vector{Float64}[]
    function λ⃗(t, λ̇₁)
        λ₁ = 1.0 + λ̇₁ * t
        λ₂ = λ₃ = 1 / sqrt(λ₁)
        return [λ₁, λ₂, λ₃]
    end
    for (i, t) in enumerate(range(0.0, 7 / q, length=50)[2:end[]])
        @show i, t
        loading = (F = λ⃗(t, q), t = t)
        push!(s, SecondPiolaKirchoffStressTensor!(model, loading, p))
    end

    λ₁ = model.history.value[1, :][2:end]
    λ₃ = model.history.value[3, :][2:end]
    s₁ = getindex.(s, 1)
    s₃ = getindex.(s, 3)

    s₁₃ = @. s₁ - s₃ * λ₃ / λ₁

    lines!(
        ax,
        λ₁,
        s₁₃ ./ 1e6,
        label="Predicted - $(q) 1/s",
        linewidth=4
    )
end
axislegend(position=:lt)
current_figure()
