# From https://www.instructables.com/id/Easy-Raspberry-Pi-Based-ScreensaverSlideshow-for-E/
import os, random

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("img-run.py")
print("----------")

# stop any existing sketches or films
os.system('killall omxplayer')
os.system('killall java')

path = "/home/pi/src/vrniture-pictures"

os.system( 'DISPLAY=:0 feh -Y -x -q -D 10 -B black --auto-rotate -F -Z -z -r ' + path )
