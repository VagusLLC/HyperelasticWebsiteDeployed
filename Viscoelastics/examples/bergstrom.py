import scipy.integrate
from pylab import *
from matplotlib.pyplot import *

def ramp(x): 
    return (x+abs(x))/2.0

def toVec(A):
    return array([A[0][0], A[1][1], A[2][2]])

def invLangevin(x):
    EPS = spacing(1)
    if type(x) == float or type(x) == np.float64:
        if x >= 1-EPS: x = 1-EPS
        if x <= -1+EPS: x = -1+EPS
        if abs(x) < 0.839:
            return 1.31435*tan(1.59*x)+0.911249*x
        return 1.0/(sign(x)-x)
    x[x >= 1-EPS] = 1-EPS
    x[x <= -1+EPS] = -1+EPS
    res = zeros(size(x))
    index = abs(x) < 0.839
    res[index] = 1.31435*tan(1.59*x[index])+0.911249*x[index]
    index = abs(x) >= 0.839
    res[index] = 1.0/(sign(x[index])-x[index])
    return res

def EC_3D(stretch, param):
    L1 = stretch[0]
    L2 = stretch[1]
    L3 = stretch[2]
    F = array([[L1,0.0,0.0],[0.0,L2,0.0],[0.0,0.0,L3]], dtype=float)
    J = det(F)
    bstar = J**(-2/3)*dot(F, F.T)
    # print(bstar**(0.5))
    # print(dot(F, F.T))
    # print(bstar)
    lamChain = sqrt(trace(bstar)/3)
    devbstar = bstar - trace(bstar)/3*eye(3)
    # print(devbstar)
    t1 = param[0]/(J*lamChain)*invLangevin(lamChain/param[1])/invLangevin(1/param[1])
    T1 = t1*devbstar 
    T2 = param[2]*(J-1)*eye(3)
    sig = T1 + T2
    return sig

def uniaxial_stress_visco(model, timeVec, trueStrainVec, params):
    stress = zeros(len(trueStrainVec))
    lam2_1 = 1.0
    FBv1 = array([1.0, 1.0, 1.0], dtype=float)
    for i in range(1, len(trueStrainVec)):
        print(i)
        time0 = timeVec[i-1]
        time1 = timeVec[i]
        lam1_0 = exp(trueStrainVec[i-1])
        lam1_1 = exp(trueStrainVec[i])
        lam2_0 = lam2_1
        F0 = array([lam1_0, lam2_0, lam2_0], dtype=float)
        F1 = array([lam1_1, lam2_1, lam2_1], dtype=float)
        FBv0 = FBv1.copy()
        def calcS22Abs(x): return abs(
            model(F0, array([lam1_1, x, x], dtype=float), FBv0, time0, time1, params)[0][1]
            )
        lam2_1 = scipy.optimize.fmin(calcS22Abs, x0=lam2_0, xtol=1e-9, ftol=1e-9, disp=False)[0]
        res = model(F0, array([lam1_1, lam2_1, lam2_1]), FBv0, time0, time1, params)
        # print("HERE")
        stress[i] = res[0][0]
        FBv1 = res[1]
    return stress

def BB_timeDer_3D(Fv, t, params, time0, time1, F0, F1):
    mu, lamL, kappa, s, xi, C, tauBase, m, tauCut = params[:9]
    F = F0+(t-time0)/(time1-time0)*(F1-F0)
    # print("F = {}, Fv = {}".format(F, Fv))
    Fe = F / Fv
    # print("Fe = {}".format(Fe))
    Stress = toVec(EC_3D(Fe, [s*mu, lamL, kappa]))
    devStress = Stress - sum(Stress)/3.0
    tau = norm(devStress)
    lamCh = sqrt(sum(Fv*Fv)/3.0)
    lamFac = lamCh - 1.0 + xi
    gamDot = lamFac**C * (ramp(tau/tauBase - tauCut)**m)
    prefac = 0.0
    if tau > 0: prefac = gamDot/tau
    FeInv = array([1.0, 1.0, 1.0])/Fe
    # print("prefac = {}, FeInv = {}, devStress = {}, F = {}".format(prefac, FeInv, devStress, F))
    FvDot = prefac * (FeInv * devStress * F)
    # print("FvDot = {}".format(FvDot))
    return FvDot

def BB_3D(F0, F1, FBv0, time0, time1, params):
    muA, lamL, kappa, s = params[:4]
    StressA = toVec(EC_3D(F1, [muA, lamL, kappa]))
    FBv1 = scipy.integrate.odeint(BB_timeDer_3D, FBv0, [time0, time1], args=(params, time0, time1, F0, F1))[1]
    FBe1 = F1 / FBv1
    StressB = toVec(EC_3D(FBe1, [s*muA, lamL, kappa]))
    Stress = StressA + StressB
    return (Stress, FBv1)

N = 100
timeVec = linspace(0.0, 10, N)
trueStrain = linspace(0.0, 0.2, N)
params = [2.0, 3.5, 500.0, 3.0, 0.05, -0.5, 0.5, 8.0, 0.01]
# stress = <152.9633929, 148.51830355, 148.51830355>
# print(stress)

trueStress = uniaxial_stress_visco(BB_3D, timeVec,trueStrain, params)
plot(trueStrain, trueStress)
show()