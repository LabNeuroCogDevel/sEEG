#!/usr/bin/env bash
# EEG_rs
# it's resting state for intracortical eeg ("sEEG".. "stereotactic" eeg) patients

# not all bold have mprage. 
#ls -d /Volumes/L/bea_res/Data/EpilepsyMR/epilepsy_bold/E*/E*_MR*|sed 's:.*/::;s/_MR/ /'|sort -u | while read s ss; do

ls -d /Volumes/L/bea_res/Data/EpilepsyMR/epilepsy_*/E*|sed 's:.*/::'|sort -u |
   xargs heudiconv \
   -b -o /Volumes/Hera/Raw/BIDS/sEEG_rs/ \
   -c dcm2niix \
   -g all \
   -d '/Volumes/L/bea_res/Data/EpilepsyMR/epilepsy_*/{subject}/{subject}*/scans/*/DICOM/*dcm' \
   -f bids_heuristic.py \
   -s 

bids-validator /Volumes/Hera/Raw/BIDS/sEEG_rs/
