
#extract filename from path
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}" #only works with .extension not .extension.extension eg .nii.gz needs to call this twice

#for loop

for var in $(ls <path>); do

done

# reame a file
find <path to subj> -name "<what you want to find>" -exec mv {} new name.nii

#extract ACPC distance
find ~/compute/class/ -type f -name "t1_Crop_1_ACPC.txt" -exec grep -H "AC-PC distance" {} \;
