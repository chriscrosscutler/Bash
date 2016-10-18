#!/bin/bash
#SBATCH --time=50:00:00 # walltime
#SBATCH --ntasks=2 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "jlf" # job name
#SBATCH --mem-per-cpu=32768M # memory per CPU core
#SBATCH --mail-user=chris.b.cutler@gmail.com # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

ARTHOME=/fslhome/ccutle25/apps/art/
export ARTHOME
export ANTSPATH=/fslhome/ccutle25/bin/antsbin/bin/
PATH=${ANTSPATH}:${PATH}

files=$1
cd $files

mkdir $files/labels/
sh /fslhome/ccutle25/bin/antsbin/bin/antsJointLabelFusion.sh \
-d 3 \
-c 5 \
-u 40:00:00 \
-v 32gb \
-w 40:00:00 \
-z 32gb \
-o $files/labels/ \
-p $files/labels/Posteriors%02d.nii.gz \
-t $files/BrainExtractionBrain.nii.gz \
-x $files/BrainExtractionMask.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-1/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-1/OASIS-TRT-20-1_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-2/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-2/OASIS-TRT-20-2_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-3/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-3/OASIS-TRT-20-3_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-4/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-4/OASIS-TRT-20-4_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-5/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-5/OASIS-TRT-20-5_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-6/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-6/OASIS-TRT-20-6_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-7/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-7/OASIS-TRT-20-7_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-8/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-8/OASIS-TRT-20-8_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-9/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-9/OASIS-TRT-20-9_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-10/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-10/OASIS-TRT-20-10_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-11/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-11/OASIS-TRT-20-11_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-12/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-12/OASIS-TRT-20-12_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-13/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-13/OASIS-TRT-20-13_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-14/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-14/OASIS-TRT-20-14_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-15/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-15/OASIS-TRT-20-15_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-16/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-16/OASIS-TRT-20-16_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-17/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-17/OASIS-TRT-20-17_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-18/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-18/OASIS-TRT-20-18_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-19/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-19/OASIS-TRT-20-19_DKT31_CMA_labels.nii.gz \
-g /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-20/t1weighted_brain.nii.gz -l /fslhome/ccutle25/templates/OASIS/OASIS-TRT-20-20/OASIS-TRT-20-20_DKT31_CMA_labels.nii.gz \
-k 1
