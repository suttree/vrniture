# From https://stackoverflow.com/questions/54225192/how-to-play-a-shuffled-list-of-videos-in-omxplayer
import os, random

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("mov-run.py")
print("----------")

# stop any existing sketches or films
os.system('killall omxplayer.bin')
os.system('killall omxplayer')
os.system('killall java')
os.system('killall feh')

path = "/home/pi/src/vrniture-movies"
videoList = os.listdir(path)
random.shuffle(videoList)
for video in videoList:
    target = os.path.join(path, video)
    os.system('/usr/bin/omxplayer "{}" > /dev/null'.format(target))
