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
    roi="${FINALOUT//[!0-9]/}"
    val=`c3d $j -dup -lstat`
    IFS=$'\n' read -d '' -r -a arr <<< "$val"
    read -ra arr2 <<<"${arr[2]}"
    vol=${arr2[6]}
    if [ "$roi" == "72" ] || [ "$roi" == "2033" ] || [ "$roi" == "1033" ] || [ "$roi" == "1032" ]; then
      vol=0
    fi
    echo "$i $roi $vol" >> ~/antsReg.txt
    unset arr
    unset arr2
  done
done
