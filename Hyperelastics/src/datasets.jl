export Kawabata1981, Treloar1944Uniaxial

"""
Kawabata1981(λ₁)

Biaxial Experimental Data from Kawabata et al. The model is more challenging to correctly fit a hyperelastic model to and is proposed as a better test than the Treloar1944 simple tension dataset.

Data provided for fixed λ₁ of:
- 1.040
- 1.060
- 1.080
- 1.100
- 1.120
- 1.14
- 1.16
- 1.2
- 1.24
- 1.3
- 1.6
- 1.9
- 2.2
- 2.5
- 2.8
- 3.1
- 3.4
- 3.7

> Kawabata S, Matsuda M, Tei K, Kawai H. Experimental survey of the strain energy density function of isoprene rubber vulcanizate. Macromolecules. 1981 Jan;14(1):154-62.
"""
function Kawabata1981(λ₁)
    @assert λ₁ ∈ [1.040, 1.060, 1.080, 1.100, 1.120, 1.14, 1.16, 1.2, 1.24, 1.3, 1.6, 1.9, 2.2, 2.5, 2.8, 3.1, 3.4, 3.7] "λ₁ ∉ [1.040, 1.060, 1.080, 1.100, 1.120, 1.14, 1.16, 1.2, 1.24, 1.3, 1.6, 1.9, 2.2, 2.5, 2.8, 3.1, 3.4, 3.7]"
    if λ₁ == 1.040
        λ₂ = [0.981, 0.992, 1.0, 1.012, 1.020, 1.040]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.0434, 0.0525, 0.0583, 0.0676, 0.0737, 0.0846]
        s₂ = [0.0000, 0.0169, 0.0284, 0.0464, 0.0573, 0.0846]
    elseif λ₁ == 1.060
        λ₂ = [0.971, 0.988, 1.0, 1.018, 1.030, 1.060]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.0610, 0.0777, 0.0862, 0.0992, 0.1077, 0.1216]
        s₂ = [0.0000, 0.0248, 0.0421, 0.0687, 0.0852, 0.1216]
    elseif λ₁ == 1.080
        λ₂ = [0.962, 0.984, 1.000, 1.024, 1.040, 1.080]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.0859, 0.1016, 0.1130, 0.1289, 0.1396, 0.1645]
        s₂ = [0.0000, 0.0323, 0.0559, 0.0908, 0.1116, 0.1645]
    elseif λ₁ == 1.100
        λ₂ = [0.953, 0.98, 1.0, 1.03, 1.05, 1.1]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.1064, 0.1246, 0.1379, 0.1565, 0.1682, 0.1981]
        s₂ = [0.0000, 0.0394, 0.0688, 0.1114, 0.1368, 0.1981]
    elseif λ₁ == 1.120
        λ₂ = [0.945, 0.976, 1.0, 1.036, 1.06, 1.12]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.127, 0.1461, 0.1613, 0.1827, 0.1957, 0.2293]
        s₂ = [0.000, 0.0463, 0.0813, 0.1311, 0.1608, 0.2293]
    elseif λ₁ == 1.14
        λ₂ = [0.937, 0.972, 1.00, 1.042, 1.07, 1.14]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.1434, 0.1669, 0.1836, 0.2074, 0.2217, 0.2570]
        s₂ = [0.0000, 0.0529, 0.0936, 0.1499, 0.1826, 0.2570]
    elseif λ₁ == 1.16
        λ₂ = [0.928, 0.968, 1.000, 1.048, 1.080, 1.160]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.1617, 0.1860, 0.2052, 0.2306, 0.2457, 0.2835]
        s₂ = [0.0000, 0.0595, 0.1055, 0.1682, 0.2051, 0.2835]
    elseif λ₁ == 1.2
        λ₂ = [0.913, 0.960, 1.000, 1.060, 1.100, 1.200]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.1960, 0.2233, 0.2450, 0.2731, 0.2911, 0.3297]
        s₂ = [0.0000, 0.0718, 0.1283, 0.2032, 0.2448, 0.3297]
    elseif λ₁ == 1.24
        λ₂ = [0.898, 0.952, 1.000, 1.072, 1.120, 1.240]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.2272, 0.2587, 0.2816, 0.3121, 0.3304, 0.3716]
        s₂ = [0.0000, 0.0831, 0.1499, 0.2340, 0.2820, 0.3716]
    elseif λ₁ == 1.3
        λ₂ = [0.877, 0.955, 0.970, 1.000, 1.045, 1.090, 1.180, 1.300]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.270, 0.317, 0.324, 0.334, 0.341, 0.362, 0.393, 0.421]
        s₂ = [0.000, 0.112, 0.128, 0.179, 0.224, 0.274, 0.351, 0.421]
    elseif λ₁ == 1.6
        λ₂ = [0.791, 0.910, 0.940, 1.000, 1.090, 1.180, 1.360, 1.600]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.433, 0.489, 0.499, 0.512, 0.532, 0.544, 0.572, 0.610]
        s₂ = [0.000, 0.177, 0.217, 0.281, 0.367, 0.424, 0.518, 0.610]
    elseif λ₁ == 1.9
        λ₂ = [0.725, 0.865, 0.910, 1.000, 1.135, 1.270, 1.540, 1.900]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.553, 0.607, 0.617, 0.628, 0.654, 0.664, 0.701, 0.744]
        s₂ = [0.000, 0.218, 0.272, 0.362, 0.462, 0.522, 0.637, 0.744]
    elseif λ₁ == 2.2
        λ₂ = [0.674, 0.820, 0.880, 1.000, 1.180, 1.360, 1.720, 2.200]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.651, 0.699, 0.711, 0.724, 0.749, 0.761, 0.809, 0.862]
        s₂ = [0.000, 0.239, 0.315, 0.422, 0.531, 0.600, 0.735, 0.862]
    elseif λ₁ == 2.5
        λ₂ = [0.632, 0.775, 0.850, 1.000, 1.225, 1.450, 1.900, 2.500]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.740, 0.783, 0.786, 0.809, 0.830, 0.853, 0.902, 0.974]
        s₂ = [0.000, 0.255, 0.342, 0.473, 0.588, 0.671, 0.816, 0.974]
    elseif λ₁ == 2.8
        λ₂ = [0.598, 0.820, 1.000, 1.270, 1.540, 2.080, 2.800]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.827, 0.858, 0.887, 0.910, 0.942, 0.991, 1.082]
        s₂ = [0.000, 0.368, 0.516, 0.638, 0.735, 0.892, 1.082]
    elseif λ₁ == 3.1
        λ₂ = [0.568, 0.790, 1.000, 1.315, 1.630, 2.260, 3.100]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [0.919, 0.936, 0.959, 0.986, 1.019, 1.079, 1.190]
        s₂ = [0.000, 0.387, 0.557, 0.689, 0.796, 0.965, 1.190]
    elseif λ₁ == 3.4
        λ₂ = [0.542, 0.760, 1.000, 1.360, 1.720, 2.440]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [1.016, 1.014, 1.031, 1.063, 1.088, 1.161]
        s₂ = [0.000, 0.410, 0.593, 0.739, 0.853, 1.038]
    elseif λ₁ == 3.7
        λ₂ = [0.520, 1.000, 1.405]
        λ₁ = fill(λ₁, length(λ₂))
        s₁ = [1.117, 1.102, 1.136]
        s₂ = [0.000, 0.628, 0.789]
    end
    return HyperelasticBiaxialTest(λ₁, λ₂, s₁, s₂, name="Kawabata1981_$(λ₁[1])")
end

"""
Treloar1944Uniaxial()

Uniaxial data for tension of 8% S Rubber at 20C from Fig 3 of Treloar 1944. This is commonly used for testing hyperelastic models.

> Treloar LR. Stress-strain data for vulcanized rubber under various types of deformation. Rubber Chemistry and Technology. 1944 Dec;17(4):813-25.
"""
function Treloar1944Uniaxial()
    λ₁ = [1.0292, 1.1267, 1.2437, 1.3946, 1.6039, 1.8861, 2.1683, 2.4165, 3.0101, 3.5696, 4.0173, 4.7573, 5.3659, 5.7558, 6.1652, 6.4093, 6.6339, 6.8789, 7.0686, 7.1765, 7.2943, 7.4509, 7.5102, 7.6290]
    s₁ = [0.0482, 1.2927, 2.2745, 3.185, 4.1203, 5.1043, 5.921, 6.7851, 8.6818, 10.626, 12.3773, 16.1647, 19.8069, 23.3744, 27.2768, 30.8423, 34.551, 38.2599, 41.9682, 45.5557, 49.3824, 53.1619, 56.7966, 64.2572].*0.0980665
    return HyperelasticUniaxialTest(λ₁, s₁, name="treloar")
end
