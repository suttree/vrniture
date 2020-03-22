import os, random

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("vrn-run.py")
print("----------")


media = [
    'img-run.py',
    'mov-run.py',
    'sketch-run.py',
]

# chance cubes!
if (random.choice([1,2,3,4,5,6]) <= 3):
    print( '/usr/bin/env python /home/pi/src/vrniture/' + random.choice(media) + ' >> /tmp/cron.log 2>&1' )
    os.system( '/usr/bin/env python /home/pi/src/vrniture/' + random.choice(media) + ' >> /tmp/cron.log 2>&1' )

    import datetime
    if (datetime.datetime.now().hour >= 22):
        # stop any existing sketches or films
        os.system('killall omxplayer')
        os.system('killall java')
        os.system('killall feh')

        os.system('DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/breathing/" --run >> /tmp/cron.log 2>&1')
else:
    print 'Pass'
