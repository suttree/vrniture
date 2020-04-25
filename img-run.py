# From https://www.instructables.com/id/Easy-Raspberry-Pi-Based-ScreensaverSlideshow-for-E/
import os, random

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("img-run.py")
print("----------")

# stop any existing sketches or films
#os.system('killall python3')
os.system('killall omxplayer')
os.system('killall omxplayer.bin')
os.system('killall java')
os.system('killall PictureFrame.py')

os.system( "DISPLAY=:0 /usr/bin/python3 /home/pi/src/vrniture/pictureframe/PictureFrame.py" )
