#!/bin/bash
#SBATCH --time=50:00:00 # walltime
#SBATCH --ntasks=2 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH --mem-per-cpu=32768M # memory per CPU core
#SBATCH -J "pre" # job name
#SBATCH --mail-user=chris.b.cutler@gmail.com # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

ARTHOME=/fslhome/ccutle25/apps/art/
export ARTHOME
export ANTSPATH=/fslhome/ccutle25/bin/antsbin/bin/
PATH=${ANTSPATH}:${PATH}
files=$1
cd $files

if [ ! -f $files/*.nii ]; then
  ~/bin/dcm2niix/bin/dcm2niix \
  -o $files/ \
  -x y \
  -f t1 \
  $files/
fi

if [ ! -f $files/acpc.nii ]; then
  /fslhome/ccutle25/apps/art/acpcdetect \
  -M \
  -o $files/acpc.nii \
  -i $files/t1_Crop_1.nii
fi
