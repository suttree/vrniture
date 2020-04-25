#!/bin/sh

export TERM=ansi

# From https://keytosmart.com/single-board-computers/looping-video-playlist-omxplayer-raspberry-pi/
VIDEOPATH="/home/pi/src/vrniture-movies/" 
IMAGEPATH="/home/pi/src/vrniture-pictures/"
SERVICE="omxplayer"
SKETCH_SERVICE="processing"
IMG_SERVICE="pictureframe"

looping=true
while [ "$looping" = true ]; do
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
        sleep 1;

        if ps ax | grep -v grep | grep $SKETCH_SERVICE > /dev/null
        then
        sleep 10;

        if ps ax | grep -v grep | grep $IMG_SERVICE > /dev/null
        then
        sleep 10;

else
	for entry in `ls /home/pi/src/vrniture-movies/* | sort -R | head -30`
	#for entry in $VIDEOPATH/*
        do
                echo $entry

                clear

                # -r for stretched over the entire screen
                omxplayer -r $entry
        done
	looping=false
fi
done
