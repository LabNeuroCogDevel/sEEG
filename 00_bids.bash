#!/usr/bin/env bash
# EEG_rs
# it's resting state for intracortical eeg ("sEEG".. "stereotactic" eeg) patients

# not all bold have mprage. 
#ls -d /Volumes/L/bea_res/Data/EpilepsyMR/epilepsy_bold/E*/E*_MR*|sed 's:.*/::;s/_MR/ /'|sort -u | while read s ss; do

ls -d /Volumes/L/bea_res/Data/EpilepsyMR/epilepsy_*/E*|sed 's:.*/::'|sort -u |
   xargs -P3 -n1 heudiconv \
   -b -o /Volumes/Hera/Raw/BIDS/sEEG_rs/ \
   -c dcm2niix \
   -g all \
   -d '/Volumes/L/bea_res/Data/EpilepsyMR/epilepsy_*/{subject}/{subject}*/scans/*/DICOM/*dcm' \
   -f bids_heuristic.py \
   -s 

# TODO: TR is fine, correct acquistion
# # "Multiband" reports TR as .525 seconds. is probably actually 1.81 (maybe!?)
# find /Volumes/Hera/Raw/BIDS/sEEG_rs/ -iname '*.json' -ipath '*/func/*' | 
#     xargs egrep -l 'Rep.*.525' |
#     xargs sed -i 's/\(RepetitionTime": \)0.525/\11.815/;s/\(RepetitionTime": \)525.0/\11815/' 

# see
# for d in /Volumes/L/bea_res/Data/EpilepsyMR/epilepsy_bold/E07/E07_*/scans/*/; do find $d -type f -print -quit | xargs dicom_hdr -slice_times_verb 2>&1|perl -slane 'next unless m/0{5}/; print map {sprintf "%.2f\n", $_} @F;'|cat -n |sort -k2,2n; echo; done
#   # -- does not seem to be multiband, just interleaved?! total time probably 1815
#    28  1642.50
#    30  1700.00
#    32  1757.50

bids-validator /Volumes/Hera/Raw/BIDS/sEEG_rs/
