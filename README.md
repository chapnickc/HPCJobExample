# Getting Started

**NOTE: After 8-30-16 most new accounts will be created on Apex. 
The only major difference between Apex and Kepler is the server path.**


#  The Terminal

Before going any further, you should be reasonably comfortable with navigating a command-line 
Linux environment. If you are using OSX or any major Linux distribution, this is the bash shell 
and can be accessed using the "Terminal" application. If you are running Windows 10 you can 
now natively run bash natively as shown [here](http://www.howtogeek.com/265900/everything-you-can-do-with-windows-10s-new-bash-shell/). 
If you are running an earlier version of Windows, you will need to install [PuTTY](http://www.putty.org/). 

Once you have a bash shell, you should get comfortable with basic file operations such as:

- Listing the contents of a directory (folder)
- Creating and moving between directories
- Renaming files

Part 1 of [this tutorial](http://korflab.ucdavis.edu/Unix_and_Perl/current.html), written by professors at 
UC Davis, does a great job covering these topics. I used it when getting started and found it to be very helpful.

------------------------------------------------------------

# Connect to Kepler:

In order to use Saint Louis University's high performance cluster (HPC),
you must apply for a new account by contacting the administrator. 
Please contact Eric Kaufmann for more information. He is an 
Application Systems Analyst who manages the HPC, and you can reach 
him at [kaufmann@slu.edu](http://www.slu.edu/its/services-and-products/research-technology-group/rtg-team).

Once approved, you should receive an email with your password. Using this password 
and your SLU username, you will be able to login to your account through a secure shell
connection. In general, the bash syntax is `ssh <username>@<IP Address>`, where the 
IP address can be replaced with the machine's domain name, if applicable. 
For example, I use the following to login:

```bash
ssh chapnickc@kepler.slu.edu
```

This will prompt you with a password which will be the one provided via email. 
To permanently change your password type:

```bash
passwd
```

As with any shell command, type `man passwd` for more information.

Once you've connected to Kepler you will be in your home directory on the login node. 
There will be a welcome message, showing the node names, and helpful links.
A copy of this welcome page can be found [here](https://sites.google.com/a/slu.edu/atg/getting-started).


------------------------------------------------------------

# Jobs on the High-Performance Cluster

The HPC uses a version of the [Sun Grid Engine](https://en.wikipedia.org/wiki/Oracle_Grid_Engine) to 
manage parallel job scheduling on the HPC. In this context, a **job** refers to a shell script 
which contains a sequence of commands to be executed by the operating system.

At a high level, this works by submitting a job to a job queue (a group of nodes on the cluster), 
where it will run until completion.

When using Kepler, there are two types of jobs to consider:

- *interactive* jobs 
- *non-interactive* jobs


## Interactive Jobs

An interactive job allows one to run code interactively by submitting an interactive login session 
to the job scheduler. This is used for prototyping your job script with small test jobs. For larger 
jobs, please see the section below about non-interactive jobs.

To enter an interactive login session, you can use one of Kepler's two interactive queues:

1. apprun
2. apprun_mnt_xfs (for nodes that have access to the infiniband storage space)

Use the following syntax:

```bash
qlogin -q apprun
```

where the `-q` option specifies the queue you want to use.


## Non-Interactive Jobs

Large jobs should be run non-interactively using the `std` queue. This can be done using the following syntax:

```bash
qsub -q std script_name 
```

where `script_name` is replaced with the name of your job script (ie. `run.sh`).

There are a number of options you can use with the `qsub` command to do things like name your job, 
specify your queue (using the `-q` option as shown above), and more. There are a few examples in script `run.sh` that 
are discussed in the [Non-Interactive Job Example](#non-interactive-job-example) in this project. 

For more information please see the "Job Input and Output" section of [this article](http://genomics.princeton.edu/support/grids/sge.shtml).

------------------------------------------------------------

# Project Management

The Git command-line utility is available if you are at the login-node. Git is a great 
version control system that allows one to manage large projects and syncronize source 
code on different machines.

Due to both data-storage constraints, it is best practice to make your 
directories on Kepler "fetch-only". This means that you edit the code on your machine, 
commit the changes, and update Kepler's copy when you are ready to execute code.

------------------------------------------------------------

# Non-Interactive Job Example

First, login to Kepler and create a local copy of the directory by entering:

```
git clone https://github.com/chapnickc/HPCJobExample
```

The job script in this example is `run.sh`. It runs a simple MATLAB script which performs 
a basic file I/O operation, then prints the time that it took the MATLAB script to run. The
code is as follows:

```bash
#!/bin/bash
#$ -cwd
#$ -o job_output.txt
#$ -j y
#$ -S /bin/bash

start=$(date +'%s')
MATLABPATH="/cm/shared/apps/matlab/R2015a/bin/matlab"
$MATLABPATH -nodesktop -nosplash -r "addpath('"$PWD"'); disp(['Added ', '"$PWD"', ' to path']); run myscript.m; exit";
echo "The job took $(($(date +'%s') - $start)) seconds"
```

The first line is called a shebang, and tells the job scheduler that this script should be 
run in a bash shell (the default of Kepler). The subsequent lines with a `#$` are options that we are adding to the 
job submission. They could also be specified as command line arguments. 
The purpose of the options are as follows:

- `cwd` - tells the job scheduler to execute the job in the current working directory
- `-o` - specifies the output file name
- `-j y` - merge the standard error and standard output streams. This will be recorded into the output file.


In this case, we want to submit the job `run.sh`. The corresponding syntax is:

```bash
qsub -q std run.sh
```

Or if you would like to submit many jobs at once:

```bash
for i in {1..10}; do qsub -q std run.sh; done
```

To check on the status of the job, you can enter:

```bash
qstat -u $USER
```

Which will look for any jobs submitted using your username.


### Notes: 

The path to the MATLAB executable can be found from `which matlab` when you are on the login node. 

The double quotes around `$PWD` the expand the environmental variable to give
the full path of the directory in which this script is executed. When using the `addpath()` 
function in MATLAB, arguments must be provided as strings. Therefore the single quotes around `"$PWD"` must 
be present.



# Helpful Links

- [Bash Tutorial](http://korflab.ucdavis.edu/Unix_and_Perl/current.html)
- [SLU HPC Getting Started](https://sites.google.com/a/slu.edu/atg/getting-started?pli=1)
- [Sun Grid Engine](http://genomics.princeton.edu/support/grids/sge.shtml)
- [More SGE Info](https://hpc.oit.uci.edu/running-jobs)


