# From https://stackoverflow.com/questions/54225192/how-to-play-a-shuffled-list-of-videos-in-omxplayer
import os, random

# hide the cursor
os.system('setterm -cursor off')

# stop any existing sketches or films
os.system('killall omxplayer')
os.system('killall java')

path = "/home/pi/src/vrniture-movies"
videoList = os.listdir(path)
random.shuffle(videoList)
for video in videoList:
    target = os.path.join(path, video)
    os.system('/usr/bin/omxplayer "{}" > /dev/null'.format(target))
