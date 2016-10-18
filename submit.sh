#!/bin/bash

workdir=
var=`date +"%Y%m%d-%H%M%S"`
if [ ! -d "~/logfiles/$var" ]; then
  mkdir -p ~/logfiles/$var
fi

for subj in $(ls $workdir); do
sbatch \
-o ~/logfiles/$var/output_${subj}.txt \
-e ~/logfiles/$var/error_${subj}.txt \
#Enter script here
done
