#!/bin/bash
if [ -f run.sh ]                # check if job script exists in dir
then
    for i in {1..20}
    do
        qsub -q std ./run.sh    # submit the job to the standard queue
    done
fi
