#!/bin/sh

# A simple bash script that saves the BrainExtractionBrain.nii.gz files to a new folder in your subject directory.
# This folder is then rsync'd to your desktop where a for loop opens each image in quick look,
# takes a screenshot and saves it to a new folder. The resulting folder could then be opened in Preview to
# quickly scan through all the subjects or saved to a PDF for future reference.

###################
# CHANGE THESE!!! #
###################
datalocation=/fslhome/ccutle25/compute/Repeatability/Dehydration/Rerun #Folder where your subjects are located please end this file path without a /!!!!
savelocation=/fslhome/ccutle25/compute/Repeatability/Dehydration #Where you want the preview PDF to be saved please end this file path without a /!!!!
c3dLoc=/fslhome/ccutle25/apps/c3d/bin/c3d #Where C3D is
########################################################################


#Generate images
for subj in $(ls ${datalocation}/); do
echo $subj
subjdir=${datalocation}/$subj
$c3dLoc ${subjdir}/BrainExtractionBrain.nii.gz -slice x 50% -type uchar -o $subjdir/x.png
$c3dLoc ${subjdir}/BrainExtractionBrain.nii.gz -slice y 50% -type uchar -o $subjdir/y.png
$c3dLoc ${subjdir}/BrainExtractionBrain.nii.gz -slice z 50% -type uchar -o $subjdir/z.png
convert -flip $subjdir/x.png $subjdir/x.png
convert -flip $subjdir/y.png $subjdir/y.png
montage ${subjdir}/x.png ${subjdir}/y.png ${subjdir}/z.png -mode concatenate -tile 2x2 ${subj}.png
rm $subjdir/x.png
rm $subjdir/y.png
rm $subjdir/z.png
done

#Move png files to a new folder
mkdir ${savelocation}/preview/
for sub in $(ls ${datalocation}/); do
echo $sub
subjdir=${datalocation}/$sub
mv $subjdir/${sub}.png ${savelocation}/preview
done

#create PDF
cd ${savelocation}/preview/
convert *.png -gravity South -annotate 0 '%f' ${savelocation}/preview.pdf
