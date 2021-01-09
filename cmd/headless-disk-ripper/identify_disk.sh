#!/bin/bash

DEVICE=$1

echo "Identifying disk"
echo "Source $DEVICE"

ITEMS=$(udevadm info -q env -n $DEVICE)

DISK_TYPE="unknown"
if [[ $ITEMS = *ID_CDROM_MEDIA_BD* ]]
then
  DISK_TYPE="bluray"
elif [[ $ITEMS = *ID_CDROM_MEDIA_DVD* ]]
then
  DISK_TYPE="dvd"
elif [[ $ITEMS = *ID_CDROM_MEDIA_TRACK_COUNT_AUDIO* ]]
then
  DISK_TYPE="music"
fi

if [[ $DISK_TYPE = "unknown" ]]
then
  echo "Unknown disk type; exiting ..."
  exit 2
elif [[ $DISK_TYPE = "dvd" ]]
then
  echo "DVD detected - ripping via MakeMKV"
  ${RIP_DIRECTORY}/rip_dvd.sh $DEVICE
elif [[ $DISK_TYPE = "bluray" ]]
then
  echo "BluRay detected - ripping via MakeMKV"
  ${RIP_DIRECTORY}/kib/rip_bluray.sh $DEVICE
elif [[ $DISK_TYPE = "music" ]]
then
  echo "Music CD detected - ripping via abcde"
  ${RIP_DIRECTORY}/kib/rip_music.sh $DEVICE
else
  echo "Disk Type $DISK_TYPE is not currently supported"
  exit 1
fi