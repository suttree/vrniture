#!/bin/sh

export TERM=ansi

# From https://keytosmart.com/single-board-computers/looping-video-playlist-omxplayer-raspberry-pi/
VIDEOPATH="/home/pi/src/vrniture-movies/" 
IMAGEPATH="/home/pi/src/vrniture-pictures/"
SERVICE="omxplayer"
SKETCH_SERVICE="processing"
IMG_SERVICE="pictureframe"

echo '-'

looping=true
while [ "$looping" = true ]; do
        if ps ax | grep -v grep | grep $SKETCH_SERVICE > /dev/null
        then
		echo '2'
		sleep 10;
		continue;
	fi

        if ps ax | grep -v grep | grep $IMG_SERVICE > /dev/null
        then
		echo '3'
		sleep 10;
		continue;
	fi

	echo '0'
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
		echo '1'
		sleep 1;
	else
		for entry in `ls /home/pi/src/vrniture-movies/* | sort -R | head -20`
		#for entry in $VIDEOPATH/*
		do
			echo $entry

			# -r for stretched over the entire screen
			omxplayer -r $entry
		done
		looping=false
	fi

done
