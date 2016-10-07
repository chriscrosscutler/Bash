#!/bin/bash

#SBATCH --time=07:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=16384M  # memory per CPU core
#SBATCH -o /fslhome/ccutle25/logfiles/output/o_repeat_head.txt
#SBATCH -e /fslhome/ccutle25/logfiles/error/e_repeat_head.txt

# Compatibility variables for PBS. Delete if not needed.
export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch

# Set the max number of threads to use for programs using OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

# LOAD ENVIRONMENTAL VARIABLES
var=`id -un`
export ANTSPATH=/fslhome/$var/bin/antsbin/bin/
PATH=${ANTSPATH}:${PATH}

# CHANGE THESE VARIABLES!!!
DATA_DIR=~/templates/repeat_templates/head/
TEMPLATE_DIR=~/templates/OASIS/MICCAI2012-Multi-Atlas-Challenge-Data/
TEMPLATE_NAME=Repeat_template_head

#Run ANTsCT
~/bin/antsbin/bin/antsCorticalThickness.sh \
-d 3 \
-a ${DATA_DIR}/${TEMPLATE_NAME}.nii.gz \
-e ${TEMPLATE_DIR}/T_template0.nii.gz \
-t ${TEMPLATE_DIR}/T_template0_BrainCerebellum.nii.gz \
-m ${TEMPLATE_DIR}/T_template0_BrainCerebellumProbabilityMask.nii.gz \
-f ${TEMPLATE_DIR}/T_template0_BrainCerebellumExtractionMask.nii.gz \
-p ${TEMPLATE_DIR}/Priors2/priors%d.nii.gz \
-q 1 \
-o ${DATA_DIR}/antsCT/

## COPY MASK
cp ${DATA_DIR}/antsCT/BrainExtractionMask.nii.gz ${DATA_DIR}/template_BrainCerebellumMask.nii.gz

## EXTRACT BRAIN IMAGE
${ANTSPATH}/ImageMath 3 ${DATA_DIR}/template_BrainCerebellum.nii.gz m ${DATA_DIR}/template_BrainCerebellumMask.nii.gz ${DATA_DIR}/${TEMPLATE_NAME}.nii.gz

# CONVERT MASK ROI TO PROBABILITY MASK
${ANTSPATH}/SmoothImage 3 ${DATA_DIR}/template_BrainCerebellumMask.nii.gz 1 ${DATA_DIR}/template_BrainCerebellumProbabilityMask.nii.gz

# DILATE MASK IMAGE TO GENERATE EXTRACTION MASK
~/apps/c3d/bin/c3d ${DATA_DIR}/template_BrainCerebellumMask.nii.gz -dilate 1 28x28x28vox -o ${DATA_DIR}/template_BrainCerebellumExtractionMask.nii.gz

# DILATE MASK IMAGE TO GENERATE REGISTRATION MASK
~/apps/c3d/bin/c3d ${DATA_DIR}/template_BrainCerebellumMask.nii.gz -dilate 1 18x18x18vox -o ${DATA_DIR}/template_BrainCerebellumRegistrationMask.nii.gz

# COPY TISSUE SEGMENTATION
cp ${DATA_DIR}/antsCT/BrainSegmentation.nii.gz ${DATA_DIR}/template_6labels.nii.gz

# COPY TISSUE PRIORS
mkdir ${DATA_DIR}/priors/
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors1.nii.gz ${DATA_DIR}/priors/priors1.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors2.nii.gz ${DATA_DIR}/priors/priors2.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors3.nii.gz ${DATA_DIR}/priors/priors3.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors4.nii.gz ${DATA_DIR}/priors/priors4.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors5.nii.gz ${DATA_DIR}/priors/priors5.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors6.nii.gz ${DATA_DIR}/priors/priors6.nii.gz
