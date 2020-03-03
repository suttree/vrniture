# From https://stackoverflow.com/questions/54225192/how-to-play-a-shuffled-list-of-videos-in-omxplayer
import os, random

path = "/home/pi/src/vrniture/sheffield"

os.system('setterm -cursor off')

videoList = os.listdir(path)
random.shuffle(videoList)
for video in videoList:
    target = os.path.join(path, video)
    os.system('/usr/bin/omxplayer "{}" > /dev/null'.format(target))
