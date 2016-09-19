#!/bin/bash
#$ -cwd
#$ -o ./logs/job_$JOB_ID.log
#$ -j y
#$ -S /bin/bash

# ------------------------------------------
#      Commands to Run the Application
# ------------------------------------------
start=$(date +'%s')
MATLABPATH="/cm/shared/apps/matlab/R2015a/bin/matlab"
$MATLABPATH -nodesktop -nosplash -r "job_id = $JOB_ID; addpath('"$PWD"'); disp(['Added ', '"$PWD"', ' to path']); run myscript.m; exit";
echo "The job took $(($(date +'%s') - $start)) seconds"

