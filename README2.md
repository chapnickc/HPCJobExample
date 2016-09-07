


each thread acts as a single core which is managed and scheduled as a
single processor by the os


to find out which partitions are available:
```bash 
sinfo
```
The output is
```
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
defq*        up   infinite     10   idle apex,compute-[021,026-033]
hi_mem       up   infinite      2   idle compute-[018-019]
matlab       up   infinite      0    n/a
med_mem      up   infinite      1  drain compute-023
med_mem      up   infinite      3   idle compute-[022,024-025]
```

The default partition is `defq` on apex, indicated by the `*`
when you type `sinfo`





[Quick start guide](http://slurm.schedmd.com/quickstart.html)
sacct - get info about jobs
salloc - allocate resources
scancel - cancel a running job 

salloc
output:
    "alloc: Granted job allocation 23
    manpath: warning: $MANPATH set, ignoring /etc/man_db.conf"

scancel 23

if --mem parameter is omitted, the smallest amount is allocated, usually 100 MB





