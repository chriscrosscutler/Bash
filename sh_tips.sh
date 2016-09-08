
#extract filename from path
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}" #only works with .extension not .extension.extension eg .nii.gz needs to call this twice

#for loop

for var in $(ls <path>); do

done

