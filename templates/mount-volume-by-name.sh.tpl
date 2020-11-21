#!/bin/bash

# mount data volume
mkdir -p ${DATA_VOLUME_NAME}

# device mapping
DATA_VOLUME_MAPPING="/dev/disk/by-id/scsi-0DO_Volume_$DATA_VOLUME_NAME ${DATA_VOLUME_NAME}"
mount -o discard,defaults,noatime "$DATA_VOLUME_MAPPING"
echo "$DATA_VOLUME_MAPPING ext4 defaults,nofail,discard 0 0" >> /etc/fstab
