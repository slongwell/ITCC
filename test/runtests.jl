using ITCC
using Base.Test

# write your own tests here
p = [0.05 0.05 0.05 0.0 0.0 0.0 
        0.05 0.05 0.05 0.0 0.0 0.0
        0.0 0.0 0.0 0.05 0.05 0.05
        0.0 0.0 0.0 0.05 0.05 0.05
        0.04 0.04 0.0 0.04 0.04 0.04
        0.04 0.04 0.04 0.0 0.04 0.04]

k = 3
l = 2
n = 5
convergeThresh = 0.001

cX = [3 1 2 2 3 3]
cY = [1 1 2 1 2 2]

result = itcc(p, k, l, n, convergeThresh, cX, cY);



cX_expected = [1 1 2 2 3 3]
cY_expected = [1 1 1 2 2 2]

q_expected = [0.05400000000000001 0.05400000000000001 0.04200000000000001 0.0 0.0 0.0
 0.05400000000000001 0.05400000000000001 0.04200000000000001 0.0 0.0 0.0
 0.0 0.0 0.0 0.04200000000000001 0.05400000000000001 0.05400000000000001
 0.0 0.0 0.0 0.04200000000000001 0.05400000000000001 0.05400000000000001
 0.03600000000000002 0.03600000000000002 0.02800000000000001 0.02800000000000001 0.03600000000000002 0.03600000000000002
 0.03600000000000002 0.03600000000000002 0.02800000000000001 0.02800000000000001 0.03600000000000002 0.03600000000000002]

p_clust_expected = [0.3 0.0
				0.0 0.3
 				0.2 0.2]

kl_expected = 0.066335621500106

converged_expected = true

num_iters_expected = 3


@test result.cX == cX_expected
@test result.cY == cY_expected
@test isapprox(result.q, q_expected)
@test isapprox(result.p_clust, p_clust_expected)
@test isapprox(result.kl, kl_expected)
@test result.converged == converged_expected
@test result.num_iters == num_iters_expected
