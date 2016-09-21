#!/bin/bash

workDir=/Volumes/Yorick/Nate_work/Bigler_collab

cd ${workDir}/template


buildtemplateparallel.sh -d 3 -r 1 -m 30x90x20 -t GR -s CC -c 2 -j 6 -o Repeat_template_ *.nii.gz

#included scans from all participants using the first scan from morning, afternoon or evening
#included the first scan from the morning on dehydrated days
#included both He and Le scans using the first scans from morning, afternoon, or evening