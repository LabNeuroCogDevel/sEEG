import os


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes


def infotodict(seqinfo):
    t1w = create_key('sub-{subject}/anat/sub-{subject}_run-{item:02d}_T1w')
    restshort = create_key('sub-{subject}/func/sub-{subject}_task-restshort_run-{item:02d}_bold')
    restlong = create_key('sub-{subject}/func/sub-{subject}_task-restlong_run-{item:02d}_bold')
    info = {t1w: [], restlong: [], restshort: []}
    for s in seqinfo:
        if('COR T1 3D MPRAGE' in s.protocol_name) and\
          (s.dim3 == 192) and (s.dim4 == 1):
            # assume last one is always the best
            info[t1w] = [s.series_id]
        elif ('EYESFIXED' in s.protocol_name) and\
             (s.dim4 == 573):
            info[restlong].append(s.series_id)
        elif ('RESTING STATE 5' in s.protocol_name) and\
             (s.dim4 == 150):
            info[restshort].append(s.series_id)
        else:
            print(f"no match for {s.protocol_name} {s.series_id} {s.dim3} {s.dim4}")
    return info

# no match for tfl-multiecho-epinav-711 7-tfl-multiecho-epinav-711 176 1
# no match for gre_field_mapping_new 14-gre_field_mapping_new 120 1
# no match for gre_field_mapping_new 15-gre_field_mapping_new 60 1
# no match for diff113_current_PA 16-diff113_current_PA 66 113
