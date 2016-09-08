var=`date +"%Y%m%d-%H%M%S"`
mkdir -p ~/logfiles/$var
sbatch \
-o ~/logfiles/$var/output-ants.txt \
-e ~/logfiles/$var/error-ants.txt \
~/scripts/ants/repeatability/template/ANTs.sh