


for i in s*; do

	cd $i

	sbatch do_ant.sh ${i}_struct_acpc.nii.gz