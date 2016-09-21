


workDir=~/compute/Nate_work/Bigler_collab/rerun
tempDir=~/bin/Templates/old_templates/OASIS-30_Atropos_template

cd $workDir

for i in B*; do
cd $i

acpcdetect -M -o nate_acpc.nii -i nate_t1.nii

#c3d -verbose acpc.nii -resample-mm 1x1x1mm -o resampled.nii.gz

dim=3
struct=nate_acpc.nii
temp=${tempDir}/T_template0.nii.gz
mask=${tempDir}/T_template0_BrainCerebellumProbabilityMask.nii.gz
fmask=${tempDir}/T_template0_BrainCerebellumRegistrationMask.nii.gz
out=${workDir}/${i}/

echo ${ANTSPATH}/antsBrainExtraction.sh -d $dim -a $struct -e $temp -m $mask -f $fmask -o $out \
| qsub -l nodes=1:ppn=1,pmem=8gb,walltime=05:00:00 -N ssFast


cd $workDir
done
