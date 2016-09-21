
parentDir=/fslhome/kirwan/compute/Nate_work/Bigler_collab
workDir=${parentDir}/rerun
scriptDir=${parentDir}/Scripts
tempDir=/fslhome/kirwan/bin/Templates/old_templates/oasis_20


cd $workDir

for i in B*; do
cd $i

mkdir labels

### it should be %04d

sbatch ${scriptDir}/sbatch_jlf.sh \
3 \
${workDir}/${i}/labels \
BrainExtractionBrain.nii.gz \
${tempDir}/Atlases \
${tempDir}/Labels \
5 \
1 \
${workDir}/${i}/labels/Posteriors%02d.nii.gz \
BrainExtractionMask.nii.gz \
1

cd $workDir
done
