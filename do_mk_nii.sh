#!/bin/bash


### Chris's construction

#for subj in $(ls ~/compute/Repeatability/Dehydration/Rerun); do
#echo $subj
#subjDir=~/compute/Repeatability/Dehydration/Rerun/$subj
#/fslhome/ccutle25/bin/dcm2niix/bin/dcm2niix \
#-f t1 \
#$subjDir/
#done



workDir=/Volumes/Yorick/Nate_work/Bigler_collab/rerun
cd $workDir

for b in Big*; do
cd $b/dcms

#dcm2niix -f t1 ${workDir}/${b}

dcm2nii -a y -g n -x y -i *.dcm
mv co*.nii nate_t1.nii
mv nate_t1.nii ${workDir}/${b}
rm *.nii

cd $workDir
done