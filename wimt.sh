#!/bin/bash
#SBATCH --time=50:00:00 # walltime
#SBATCH --ntasks=2 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "jlf" # job name
#SBATCH --mem-per-cpu=32768M # memory per CPU core
#SBATCH --mail-user=chris.b.cutler@gmail.com # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

sub=$1
FIX=/fslhome/ccutle25/templates/repeat_templates/brain/
MOV=$1
OUT=wimt_
DIM=3
p=~/compute/Repeat_template/sub_1/labels/posteriors/

for i in $( ls ~/compute/Repeat_template/sub_1/labels/posteriors/ ); do
FIXLabel="${i/$p}"
FINALOUT=ants_"${i/$p}"

WarpImageMultiTransform $DIM $MOV ${OUT}toTemplate.nii.gz ${OUT}Warp.nii.gz ${OUT}Affine.txt -R $FIX
WarpImageMultiTransform $DIM $FIX ${OUT}toMov.nii.gz -i ${OUT}Affine.txt ${OUT}InverseWarp.nii.gz -R $MOV
WarpImageMultiTransform $DIM $FIXLabel $FINALOUT -i ${OUT}Affine.txt ${OUT}InverseWarp.nii.gz -R $MOV

#thresh and binarize output
c3d $FINALOUT -threshhold 0.3 1 1 0 -o thresh_${FINALOUT}
done
