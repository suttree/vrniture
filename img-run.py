# From https://www.instructables.com/id/Easy-Raspberry-Pi-Based-ScreensaverSlideshow-for-E/
import os, random, sys, subprocess

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("img-run.py")
print("----------")

# stop any existing sketches or films
os.system("kill -9 `ps aux | grep omxplayer | grep -v grep | awk '{print $2}'`")
os.system("kill -9 `ps aux | grep processing | grep -v grep | awk '{print $2}'`")
os.system("kill -9 `ps aux | grep java | grep -v grep | awk '{print $2}'`")
os.system("kill -9 `ps aux | grep PictureFrame | grep -v grep | awk '{print $2}'`")

#os.system( "DISPLAY=:0 /usr/bin/python3 /home/pi/src/vrniture/pictureframe/PictureFrame.py" )
subprocess.Popen([ '/usr/bin/python3', '/home/pi/src/vrniture/pictureframe/PictureFrame.py' ])

sys.exit(0)
