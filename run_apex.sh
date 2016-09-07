#!/bin/bash
#$ -cwd
#$ -o job_output.txt
#$ -j y
#$ -S /bin/bash

# ------------------------------------------
#      Commands to Run the Application
# ------------------------------------------
start=$(date +'%s')

MATLABPATH="/cm/shared/apps/MATLAB/R2016a/bin/matlab"
$MATLABPATH -nodesktop -nosplash -r "addpath('"$PWD"'); disp(['Added ', '"$PWD"', ' to path']); run myscript.m; exit";

echo "The job took $(($(date +'%s') - $start)) seconds"

