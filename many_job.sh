

if [ -f run.sh ]; then
    for i in {1..20}
    do
        qsub -q std ./run.sh
    done
fi





