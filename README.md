#ITCC: Information Theoretic Co-Clustering  
2015-12-04  
[Scott Longwell](https://github.com/slongwell)  
[Alex Williams](https://github.com/ahwillia)  

Implements a 2-dimensional verision of ITCC as described by Dhillon, et al:  
I.S. Dhillon, S. Mallela, and D.S. Modha, "Information-Theoretical
Coclustering, Proc. Ninth ACM SIGKDD Int'l Conf. Knowledge
Discovery and Data Mining (KDD '03), 2003.  
[Paper](http://www.cs.utexas.edu/users/inderjit/public_papers/kdd_cocluster.pdf)  

For an example application and N-dimensional Python implementation, see Percha & Altman:  
B. Percha, R.B. Altman, "Learning the Structure of Biomedical Relationships from Unstructured Text," PLoS Comp. Bio., 2015.  
[Paper](http://www.ncbi.nlm.nih.gov/pubmed/26219079)  
[Github](https://github.com/blpercha/ebc)

##Requirements  
Uses the Kullback-Leibler Divergence (KL-D) implemented in the `Distances` package.  

##Input  
`itcc(p, k, l, n_iters, convergeThresh, cX, cY)` 

`p`: A joint probability matrix  
`k`: Number of row-clusters  
`l`: Number of column-clusters  
`n_iters`: Maximum number of iterations  
`convergeThresh`: Threshold at which algroithm has is said to have converged, i.e. KL-D between p and q has not decreased significantly between iterations  
`cX`: Initial row-cluster assignments (optional; default to random assignments)  
`cY`: Initial column-cluster assignments (optional; default to random assignments)  

##Output  
An instance of the `ITCC_Result` type, which has the following attributes:  

`cX`: Final row-cluster assignments  
`cY`: Final column-cluster assignmnents  
`q`: Final q  
`p_clust`: View of p given final cX and cY  
`kl`: Final Kullback-Leibler divergence between p and q  
`converged`: Boolean indicating if the algorithm converged  
`num_iters`: Number of iterations peformed by the algorithm  



##TODO
1) Sparse matrix to handle larger inputs  
2) N-dimensionalize  
3) Jitter to break ties  
