#!/bin/bash
#$ -cwd -  
#$ -j y   
#$ -S /bin/bash 

# 1. tells the job scheduler to execute the job in the current working directory.
# 2. "-j y" means to merge the standard error stream into the standard output stream 
#         instead of having two separate error and output streams.  
# 3. tells the job scheduler to use the bash shell (default on Kepler)

# -----------------------------------------
#      Commands to Run the Application 
# ------------------------------------------
date
module load matlab
matlab -nodesktop -nosplash -r "run myscript.m; quit()"
