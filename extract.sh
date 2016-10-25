
touch ~/antsReg.txt
for i in $(ls ~/compute/Repeatability/ANTsCT); do
  sub=~/compute/Repeatability/ANTsCT/$i
  x=${sub}/antsCT/
  for j in $(ls ${sub}/antsCT/thresh_*); do
    FINALOUT="${j/$x}"
    echo 1
    echo FINALOUT:
    echo $FINALOUT
    val=`c3d $j -dup -lstat`
    echo 2
    echo val:
    echo $val
    echo $($i $FINALOUT $val) >> antsReg.txt
    echo 3
  done
done

for i in $(ls ~/compute/Repeatability/ANTsCT); do
  sub=~/compute/Repeatability/ANTsCT/$i
  echo sub:
  echo $sub
  x=${sub}/antsCT/
  for j in $(ls ${sub}/antsCT/thresh_*); do

    echo FINALOUT:
    echo $FINALOUT
    echo i:
    echo $i
  done
done
