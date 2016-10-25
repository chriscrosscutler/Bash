#!/bin/bash
#SBATCH --time=10:00:00 # walltime
#SBATCH --ntasks=2 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "tofile" # job name
#SBATCH -o /fslhome/ccutle25/logfiles/output_tofile.txt
#SBATCH -e /fslhome/ccutle25/logfiles/error_tofile.txt
#SBATCH --mem-per-cpu=32768M # memory per CPU core
#SBATCH --mail-user=chris.b.cutler@gmail.com # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

touch ~/antsReg.txt
for i in $(ls ~/compute/Repeatability/ANTsCT); do
  sub=~/compute/Repeatability/ANTsCT/$i
  x=${sub}/antsCT/
  for j in $(ls ${sub}/antsCT/thresh_*); do
    FINALOUT="${j/$x}"
    val=`c3d $j -dup -lstat`
    echo "$i $FINALOUT $val"
  done
done >> antsReg.txt
