module ITCC

using Distances
include("utils.jl")

export itcc, ITCC_Result

type ITCC_Result<:Any
    cX::Array{UInt,2}
    cY::Array{UInt,2}
    q::Matrix{Float64}
    p_clust::Matrix{Float64}
    kl::Float64
    converged::Bool
    num_iters::UInt
end


# itcc with option to specify vectors of initial partions
function itcc(p::Array{Float64,2}, k::UInt, l::UInt, n_iters::UInt, convergeThresh::Float64, cX::Array{UInt,2}, cY::Array{UInt,2}) 
    m = size(p,1)
    n = size(p,2)
    
    converged = false
    kl_curr = 0.0
    kl_prev = 0.0
    num_iters = 0
    q = calc_q(p, 1:m, cX, 1:n, cY)
    kl_curr = kl_divergence(vec(p), vec(q))
    
    for i in 1:n_iters
        kl_prev = kl_curr
        num_iters = i
        # Update cX, q
        cX = next_cX(p,q, cX, k)
        q = calc_q(p, 1:m, cX, 1:n, cY)
        
        # Update cY, q
        cY = next_cY(p,q, cY, l)
        q = calc_q(p, 1:m, cX, 1:n, cY)
        
        kl_curr = kl_divergence(vec(p), vec(q))
        if (kl_prev - kl_curr) < convergeThresh
            converged = true
            break
        end
    end
    
    return ITCC_Result(cX, cY, q, prob_clust(p, 1:k,cX, 1:l,cY), kl_curr, converged, num_iters)
end

# If no cX, cY are specified, default to random assignments
function itcc(p::Array{Float64,2}, k::UInt, l::UInt, n_iters::UInt, convergeThresh::Float64)
    cX = rand(1:k, size(p,1))  
    cY = rand(1:l, size(p,2))
    itcc(p, k, l, n_iters, convergeThresh, cX, cY)
end


end # module
