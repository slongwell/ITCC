prob_clust(P, xhat, cX, yhat, cY) = sum(P[cX.==xhat,cY.==yhat])

function prob_clust(P, Xhat::UnitRange, cX, Yhat::UnitRange, cY)
	output = Array(Float64, (length(Xhat), length(Yhat)))
    for xhat in Xhat
        for yhat in Yhat
            output[xhat, yhat] = prob_clust(P, xhat,cX, yhat,cY)
    	end
	end
	return output
end


prob_x_given_xhat(P, x, xhat, cX) = sum(P[x,:]) / sum(P[cX.==xhat,:])
prob_y_given_yhat(P ,y, yhat, cY) = sum(P[:,y]) / sum(P[:,cY.==yhat])

prob_Y_given_x(P, x) = P[x,:] / sum(P[x,:])
prob_X_given_y(P, y) = P[:,y] / sum(P[:,y])


calc_q(p, x,cX, y,cY) = prob_clust(p, cX[x],cX, cY[y], cY) * prob_x_given_xhat(p, x, cX[x],cX) * prob_y_given_yhat(p, y, cY[y],cY)

function calc_q(p, X::UnitRange, cX, Y::UnitRange, cY)
	output = Array(Float64, (length(X), length(Y)))
	for x in X
        for y in Y
            output[x,y] = calc_q(p, x,cX, y,cY)
    	end
	end
	return output
end

prob_Y_given_xhat(P, xhat,cX) = sum(P[cX.==xhat,:] / sum(P[cX.==xhat,:]), 1)
prob_X_given_yhat(P, yhat,cY) = sum(P[:,cY.==yhat] / sum(P[:,cY.==yhat]), 2)



function next_cx(p,q, x::Int,cX::Array, k)
    q_dist_xhat = Array(Float64, k)
    p_dist_x = prob_Y_given_x(p,x)

    for xhat in 1:k
        q_dist_xhat[xhat] = kl_divergence( vec(p_dist_x), vec(prob_Y_given_xhat(q, xhat,cX)) )
    end
    return indmin(q_dist_xhat)
end

function next_cX(p,q, cX::Array, k)
    output = Array(Int, size(cX))
    for x in 1:size(cX,2)
        output[x] = next_cx(p,q, x,cX, k)
    end
    return output
end


function next_cy(p,q, y::Int,cY::Array{Int32,2}, l)
    q_dist_yhat = Array(Float64,l)
    p_dist_y = prob_X_given_y(p,y)
    for yhat in 1:l
        q_dist_yhat[yhat] = kl_divergence( vec(p_dist_y), vec(prob_X_given_yhat(q, yhat, cY)) )
    end
    return indmin(q_dist_yhat)
end

function next_cY(p,q, cY::Array{Int32,2}, l)
    output = Array(Int, size(cY))
    for y in 1:size(cY,2)
        output[y] = next_cy(p,q, y, cY, l)
    end
    return output
end


function printState()
    println("cX:",cX, " cY:",cY)
    println(round( q, 3))
    println(prob_clust(p, 1:k,cX, 1:l,cY))
end
