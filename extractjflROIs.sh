#!/bin/bash

#############################################################################
# Use this script to extract ROI volumes after running antsJointLabelFusion #
# It exports the volumes into a .csv that can be used in R		            #
#############################################################################

#########################
# Edit these variables: #
#########################

# Note: You will also need to edit the c3d command to match how your directories are set up.

# This is the location of your subjects
dir="~/compute/Repeatability/ANTsCT/"
# Where you want you .csv file saved.
dataLocation="/fslhome/ccutle25/"

cd $dir

labelArray=(
'Subject_ID'
'background'
'left_lateral_ventricle'
'left_inferior_lateral_ventricle'
'left_cerebellum_exterior'
'left_cerebellum_white_matter'
'left_thalamus_proper'
'left_caudate'
'left_putamen'
'left_pallidum'
'3rd_ventricle'
'4th_ventricle'
'Brain_stem'
'left_hippocampus'
'left_amygdala'
'CSF'
'left_accumbens_area'
'left_ventral_DC'
'right_lateral_ventricle'
'right_inferior_lateral_ventricle'
'right_cerebellum_exterior'
'right_cerebellum_white_matter'
'right_thalamus_proper'
'right_caudate'
'right_putamen'
'right_pallidum'
'right_hippocampus'
'right_amygdala'
'right_accumbens_area'
'right_ventral_DC'
'left_basal_forebrain'
'right_basal_forebrain'
'cerebellar_vermal_lobules_I-V'
'cerebellar_vermal_lobules_VI-VII'
'cerebellar_vermal_lobules_VIII-X'
'left_caudal_anterior_cingulate'
'left_caudal_middle_frontal'
'left_cuneus'
'left_entorhinal'
'left_fusiform'
'left_inferior_parietal'
'left_inferior_temporal'
'left_isthmus_cingulate'
'left_lateral_occipital'
'left_lateral_orbitofrontal'
'left_lingual'
'left_medial_orbitofrontal'
'left_middle_temporal'
'left_parahippocampal'
'left_paracentral'
'left_pars_opercularis'
'left_pars_orbitalis'
'left_pars_triangularis'
'left_pericalcarine'
'left_postcentral'
'left_posterior_cingulate'
'left_precentral'
'left_precuneus'
'left_rostral_anterior_cingulate'
'left_rostral_middle_frontal'
'left_superior_frontal'
'left_superior_parietal'
'left_superior_temporal'
'left_supramarginal'
'left_transverse_temporal'
'left_insula'
'right_caudal_anterior_cingulate'
'right_caudal_middle_frontal'
'right_cuneus'
'right_entorhinal'
'right_fusiform'
'right_inferior_parietal'
'right_inferior_temporal'
'right_isthmus_cingulate'
'right_lateral_occipital'
'right_lateral_orbitofrontal'
'right_lingual'
'right_medial_orbitofrontal'
'right_middle_temporal'
'right_parahippocampal'
'right_paracentral'
'right_pars_opercularis'
'right_pars_orbitalis'
'right_pars_triangularis'
'right_pericalcarine'
'right_postcentral'
'right_posterior_cingulate'
'right_precentral'
'right_precuneus'
'right_rostral_anterior_cingulate'
'right_rostral_middle_frontal'
'right_superior_frontal'
'right_superior_parietal'
'right_superior_temporal'
'right_supramarginal'
'right_transverse_temporal'
'right_insula'
)

printf "%s," "${labelArray[@]}" > $dataLocation/reg.csv
printf "\n" >> $dataLocation/reg.csv

for subj in $(ls $dir); do
lineArray=()
subjDir=$subj
output="$(/fslhome/ccutle25/apps/c3d/bin/c3d  /fslhome/ccutle25/rerun/${subj}/nate_BrainExtractionBrain.nii.gz /fslhome/ccutle25/rerun/${subj}/extra_files_jlf/jlf_Labels.nii.gz -label-statistics)"

arr=($output)
i=0
lineNum=0

while [ $lineNum -lt 100 ]
do

if [ $lineNum -le 1 ]
then
num=$((lineNum*8))
num2=$((num+6))
else
num=$((lineNum*10-2))
num2=$((num+6))
fi

###########################################################################
# Remove ROI's that don't always appear.				 				  #
# NOTE: There may be other ROI's that cause problems. 			 		  #
# Pay attention to your output files and adjust these values accordingly. #
#									 									  #
# These commands remove the following ROI's:			  	  			  #
# Left_Vessel, Right_Vessel, and Optic_Chiasm.				 			  #
###########################################################################

if [[ "${arr[$num]}" == "30" ]]
then
:
elif [[ "${arr[$num]}" == "62" ]]
then
:
elif [[ "${arr[$num]}" == "85" ]]
then
:
elif [[ "${arr[$num]}" == "LabelID" ]]
then
:
else
lineArray[$lineNum]=${arr[$num2]}
fi
lineNum=$((lineNum+1))
done

#############
# SAVE DATA #
#############

printf "$subj" >> $dataLocation/data_re.csv
printf "," >> $dataLocation/data_re.csv
printf "%s," "${lineArray[@]}" >> $dataLocation/data_re.csv
printf "\n" >> $dataLocation/data_re.csv

done
