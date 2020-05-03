import os, sys, subprocess

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("mov-run.py")
print("----------")

# stop any existing sketches or films
os.system("kill -9 `ps aux | grep omxplayer | grep -v grep | awk '{print $2}'`")
os.system("kill -9 `ps aux | grep java | grep -v grep | awk '{print $2}'`")
os.system("kill -9 `ps aux | grep processing | grep -v grep | awk '{print $2}'`")
os.system("kill -9 `ps aux | grep PictureFrame | grep -v grep | awk '{print $2}'`")

print("Running movs")

#os.system('/home/pi/src/vrniture/./mov-run.sh')
subprocess.Popen([ '/home/pi/src/vrniture/./mov-run.sh' ])

sys.exit(0)
