#!/bin/bash

DEVICE=$1

echo "Starting DVD ripping"
echo "Source $DEVICE"

echo "Getting title data"
TITLE=$(makemkvcon -r info disk:9999 | grep -i $DEVICE | awk -F, '{ print $6 }' | tr -d '"')
TITLE=$(echo $TITLE | sed -e 's/ /_/g')

echo "Found title: $TITLE"

FULL_PATH="/mnt/media/arm/media/dvd/$TITLE"
echo "Creating RAW Path - $FULL_PATH"
mkdir -p $FULL_PATH

makemkvcon mkv dev:$DEVICE all $FULL_PATH

eject $DEVICE