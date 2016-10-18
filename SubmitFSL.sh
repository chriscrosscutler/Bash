#!/bin/bash
for i in $(ls <filepath to script folder>); do
echo $i
sbatch <filepath to scripts>$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/dehydration/acpcdistance/); do
echo $i
sh /fslhome/ccutle25/scripts/ants/repeatability/dehydration/acpcdistance/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/ucsd/pre/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/ucsd/pre/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/ucsd/jlfrerun/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/ucsd/jlfrerun/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/mios/jlf/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/mios/jlf/$i
done


for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/ANTs/pre/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/ANTs/pre/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/ANTsCT/pre/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/ANTsCT/pre/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/ANTsReg); do
echo $i

sbatch /fslhome/ccutle25/scripts/ants/repeatability/ANTsReg/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/ANTsCT/ants/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/ANTsCT/ants/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/mios/pre/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/mios/pre/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/dehydration/rerun/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/dehydration/rerun/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/dehydration/rerun/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/dehydration/rerun/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/dehydration/repeat_template/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/dehydration/repeat_template/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/dehydration/pre/subj9/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/dehydration/pre/subj9/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/dehydration/jlf/subj9jlf/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/dehydration/jlf/subj9jlf/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/repeatability/dehydration/jlf/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/repeatability/dehydration/jlf/$i
done

for i in $(ls /fslhome/ccutle25/scripts/ants/mios/jlfrerun/); do
echo $i
sbatch /fslhome/ccutle25/scripts/ants/mios/jlfrerun/$i
done
