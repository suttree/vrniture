# From https://stackoverflow.com/questions/54225192/how-to-play-a-shuffled-list-of-videos-in-omxplayer
import os, random

from omxplayer.player import OMXPlayer
from time import sleep

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("mov-run.py")
print("----------")

# stop any existing sketches or films
os.system('killall omxplayer.bin')
os.system('killall omxplayer')
os.system('killall java')
os.system('killall feh')

player = None
path = "/home/pi/src/vrniture-movies"
videoList = os.listdir(path)
random.shuffle(videoList)

for video in videoList:
    target = os.path.join(path, video)

    if player is None:
        player = OMXPlayer(target, args=['--no-osd'])
    else:
        player.load(target)

    # it takes about this long for omxplayer to warm up and start displaying a picture on a rpi3
    sleep(2.5)

    # throw in a random pause() here?

    player.play_sync()
    player.quit()
