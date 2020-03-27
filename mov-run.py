import os, random

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("mov-run.py")
print("----------")

# stop any existing sketches or films
#os.system('killall omxplayer.bin')
#os.system('killall omxplayer')
#os.system('killall java')
#os.system('killall feh')

os.system('./mov-run.sh')

#path = "/home/pi/src/vrniture-movies/"
#videoList = os.listdir(path)

# Create a playlist and play
#with open('./playlist.txt', 'w') as playlist:
#    for video in videoList:
#        playlist.write(path + video + '\n')
#
#os.system('mplayer -fs -shuffle -playlist ./playlist.txt')
