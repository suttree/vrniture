# From https://keytosmart.com/single-board-computers/looping-video-playlist-omxplayer-raspberry-pi/

#!/bin/sh

# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

# set here the path to the directory containing your videos
VIDEOPATH="/home/pi/src/vrniture-movies/" 

# you can normally leave this alone
SERVICE="omxplayer"

# now for our infinite loop!
while true; do
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
fi
done

# kick off another script now that we're done - breathing?
