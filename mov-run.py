import os

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("mov-run.py")
print("----------")

os.system('killall omxplayer')
os.system('killall omxplayer.bin')
os.system('killall java')
os.system('killall PictureFrame.py')

os.system('/home/pi/src/vrniture/./mov-run.sh')
print("mov done")
print("--------")
