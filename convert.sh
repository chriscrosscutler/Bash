#!/bin/bash
# change filepath to the path where your raw DICOMs are stored
# input directory for dcm2nii needs /* at end of

for subj in $(ls <Path to subjects>); do
echo $subj
subjDir=<Path to subjects>/$subj
/fslhome/ccutle25/bin/dcm2niix/bin/dcm2niix \
-f t1 \
$subjDir/
done

<<<<<<< Updated upstream
for subj in $(ls ~/compute/Repeatability/ANTsCT); do
echo $subj
subjDir=~/compute/Repeatability/ANTsCT/$subj
=======
for subj in $(ls ~/compute/Repeatability/ANTs/sub5_9/); do
echo $subj
subjDir=~/compute/Repeatability/ANTs/sub5_9/$subj
>>>>>>> Stashed changes
/fslhome/ccutle25/bin/dcm2niix/bin/dcm2niix \
-f t1 \
$subjDir/
done
<<<<<<< Updated upstream
<<<<<<< Updated upstream

for subj in $(ls ~/compute/class); do
echo $subj
subjDir=~/compute/class/$subj
/fslhome/ebaughan/apps/dcm2niix/bin/dcm2niix \
-o ${subjDir}/t1/ \
-x y
$subjDir/
done

/fslhome/ebaughan/apps/dcm2niix/bin/dcm2niix \
-o ~/compute/class/1304/t1/ \
-x y \
~/compute/class/1304/DICOM/
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
