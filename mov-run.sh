# From https://keytosmart.com/single-board-computers/looping-video-playlist-omxplayer-raspberry-pi/

#!/bin/sh

# get rid of the cursor so we don't see it when videos are running
export TERM=xterm
setterm -term xterm -cursor off
xdotool mousemove 800 800
DISPLAY=:0 xdotool mousemove 800 800
export TERM=xterm && DISPLAY=:0 xdotool mousemove 800 800

# set here the path to the directory containing your videos
VIDEOPATH="/home/pi/src/vrniture-movies/" 
IMAGEPATH="/home/pi/src/vrniture-pictures/"

# you can normally leave this alone
SERVICE="omxplayer"

looping=true

# now for our infinite loop!
while [ "$looping" = true ]; do
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
        sleep 1;
else
	#for entry in `ls /home/pi/src/vrniture-movies | sort -R | head -20`
	for entry in $VIDEOPATH/*
        do
		echo $entry

                clear

                # -r for stretched over the entire screen
                omxplayer -r $entry > /dev/null
        done
	looping=false
fi
done

# kick off another script now that we're done - breathing?
DISPLAY=:0 feh -Y -x -q -D 90 -B black --auto-rotate -F -Z -z --on-last-slide quit -r ${IMAGEPATH}
