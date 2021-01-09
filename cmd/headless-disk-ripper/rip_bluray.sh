#!/bin/bash

DEVICE=$1

echo "Starting Bluray ripping"
echo "Source $DEVICE"

echo "Getting disc data"
DISC_DATA=$(makemkvcon -r info disk:9999 | grep -i $DEVICE)
echo "Getting disc number"
DISC_NUM=$(echo $DISC_DATA | grep -oP '(?<=:).*?(?=,)' )
echo "Getting title data"
TITLE=$(echo $DISC_DATA | awk -F, '{ print $6 }' | tr -d '"')
TITLE=$(echo $TITLE | sed -e 's/ /_/g')

echo "Found title: $TITLE"

FULL_PATH="/mnt/media/arm/media/bluray/$TITLE"
echo "Creating RAW Path - $FULL_PATH"
mkdir -p $FULL_PATH

makemkvcon mkv dev:$DEVICE all $FULL_PATH

eject $DEVICE