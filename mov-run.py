import os

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("mov-run.py")
print("----------")

# stop any existing sketches or films
os.system('killall python3')

os.system('/home/pi/src/vrniture/./mov-run.sh > /tmp/cron.log')
