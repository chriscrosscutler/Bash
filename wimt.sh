#!/bin/bash
#SBATCH --time=50:00:00 # walltime
#SBATCH --ntasks=2 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH -J "jlf" # job name
#SBATCH --mem-per-cpu=32768M # memory per CPU core
#SBATCH --mail-user=chris.b.cutler@gmail.com # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

sub=$1
FIX=/fslhome/ccutle25/templates/repeat_templates/brain/
MOV=$1
OUT=wimt_
DIM=3
p=~/compute/Repeat_template/sub_1/labels/posteriors/

for i in $( ls ~/compute/Repeat_template/sub_1/labels/posteriors/ ); do
FIXLabel="${i/$p}"
FINALOUT=ants_"${i/$p}"

WarpImageMultiTransform $DIM $MOV ${OUT}toTemplate.nii.gz ${OUT}Warp.nii.gz ${OUT}Affine.txt -R $FIX
WarpImageMultiTransform $DIM $FIX ${OUT}toMov.nii.gz -i ${OUT}Affine.txt ${OUT}InverseWarp.nii.gz -R $MOV
WarpImageMultiTransform $DIM $FIXLabel $FINALOUT -i ${OUT}Affine.txt ${OUT}InverseWarp.nii.gz -R $MOV

#thresh and binarize output
#c3d test.img -binarize -o binary.img
c3d $FINALOUT -threshhold 0.3 1 1 0 -o thresh_${FINALOUT}
done

WarpImageMultiTransform ImageDimension moving_image output_image  -R reference_image --use-NN   SeriesOfTransformations--(See Below)
 SeriesOfTransformations --- WarpImageMultiTransform can apply, via concatenation, an unlimited number of transformations to your data .
 Thus, SeriesOfTransformations may be  an Affine transform followed by a warp  another affine and then another warp.
  Inverse affine transformations are invoked by calling   -i MyAffine.txt
 InverseWarps are invoked by passing the InverseWarp.nii.gz  filename (see below for a note about this).

 Example 1: Mapping a warped image into the reference_image domain by applying abcdWarp.nii.gz and then abcdAffine.txt

WarpImageMultiTransform 3 moving_image output_image -R reference_image abcdWarp.nii.gz abcdAffine.txt

 Example 2: To map the fixed/reference_image warped into the moving_image domain by applying the inversion of abcdAffine.txt and then abcdInverseWarp.nii.gz .

WarpImageMultiTransform 3 reference_image output_image -R moving_image -i  abcdAffine.txt abcdInverseWarp.nii.gz


  Note that the inverse maps (Ex. 2) are passed to this program in the reverse order of the forward maps (Ex. 1).
 This makes sense, geometrically ... see ANTS.pdf for visualization of this syntax.

 Compulsory arguments:

 ImageDimension: 2 or 3 (for 2 or 3 Dimensional registration)

 moving_image: the image to apply the transformation to

 output_image: the resulting image


 Optional arguments:

 -R: reference_image space that you wish to warp INTO.
       --tightest-bounding-box: Computes the tightest bounding box using all the affine transformations. It will be overrided by -R reference_image if given.
       --reslice-by-header: equivalient to -i -mh, or -fh -i -mh if used together with -R. It uses the orientation matrix and origin encoded in the image file header.
       It can be used together with -R. This is typically not used together with any other transforms.

 --use-NN: Use Nearest Neighbor Interpolation.

 --use-BSpline: Use 3rd order B-Spline Interpolation.

 --use-ML sigma: Use anti-aliasing interpolation for multi-label images, with Gaussian smoothing with standard deviation sigma.

                 Sigma can be specified in physical or voxel units, as in Convert3D. It can be a scalar or a vector.

                 Examples:  --use-ML 0.4mm    -use-ML 0.8x0.8x0.8vox
 -i: will use the inversion of the following affine transform.



 Other Example Usages:
 Reslice the image: WarpImageMultiTransform 3 Imov.nii.gz Iout.nii.gz --tightest-bounding-box --reslice-by-header
 Reslice the image to a reference image: WarpImageMultiTransform 3 Imov.nii.gz Iout.nii.gz -R Iref.nii.gz --tightest-bounding-box --reslice-by-header

 Important Notes:
 Prefixname "abcd" without any extension will use ".nii.gz" by default
 The abcdWarp and abcdInverseWarp do not exist. They are formed on the basis of abcd(Inverse)Warp.nii.gz when calling WarpImageMultiTransform, yet you have to use them as if they exist.
-bash-4.1$
