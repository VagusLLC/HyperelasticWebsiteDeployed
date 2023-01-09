function extrapolate(f,
                    h_::Number;
                    contract::Number=oftype(float(real(h_)), 0.125),
                    x0::Number=zero(h_),
                    power::Number=1,
                    abstol::Real=0,
                    reltol::Real = abstol > zero(abstol) ? zero(one(float(real(x0+h_)))) : sqrt(eps(typeof(one(float(real(x0+h_)))))),
                    maxeval::Integer=typemax(Int),
                    breaktol::Real=2)
    # use a change of variables x = 1/u
    if isinf(x0)
        return extrapolate(u -> f(inv(u)), inv(h_); reltol=reltol, abstol=abstol, maxeval=maxeval, contract = abs(contract) > 1 ? inv(contract) : contract, x0=inv(x0), power=power)
    end
    @assert reltol ≥ 0 "reltol must be greater than nonnegative"
    @assert abstol ≥ zero(abstol) "abstol must be greater than nonnegative"
    @assert breaktol > 0 "breaktol must be positive"
    @assert 0 < abs(contract) < 1 "contract must be in (0, 1)"

    h::typeof(float(x0+h_*contract)) = h_
    invcontract = inv(contract)^power
    neville = [f(x0+h)] # the current diagonal of the Neville tableau
    f₀ = neville[1]
    err::typeof(float(norm(f₀))) = Inf
    for _ in 1:maxeval
        h *= contract
        push!(neville, f(x0+h))
        c = invcontract
        minerr′ = oftype(err, Inf)
        for i = length(neville)-1:-1:1
            old = neville[i]
            neville[i] = neville[i+1] + (neville[i+1] - neville[i]) / (c - 1)
            err′ = norm(neville[i] - old)
            minerr′ = min(minerr′, err′)
            if err′ < err
                f₀, err = neville[i], err′
            end
            c *= invcontract
        end
        (minerr′ > breaktol*err || !isfinite(minerr′)) && break # stop early if error increases too much
        err ≤ max(reltol*norm(f₀), abstol) && break # converged
    end
    return f₀
end
