for i in $(ls ~/compute/Repeatability/Dehydration/Rerun/); do
echo $i
rm -R ~/compute/Repeatability/Dehydration/Rerun/${i}/labels
done