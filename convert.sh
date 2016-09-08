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

