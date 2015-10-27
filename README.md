Copy of the fork https://github.com/scottdaniel/LatentStrainAnalysis

this will be remade to work with fasta files and with the PBS compute cluster software at the University of Arizona

Welcome to the Latent Strain Analysis (LSA) code repository!

LSA was developed as a pre-assembly tool for partitioning metagenomic reads. It uses a hyperplane hashing function and streaming SVD in order to find covariance relations between k-mers. The code, and the process outline in LSFScripts in particular, have been optimized to scale to massive data sets in fixed memory with a highly distributed computing environment.

## Documentation ##
Documentation for LSA, including a "getting started" tutorial with accompanying test data, and step-by-step instructions for analyzing large collections, can be found at: http://latentstrainanalysis.readthedocs.org/
