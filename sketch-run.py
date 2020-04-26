#! /usr/bin/env python

import sys, os
from datetime import datetime

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("sketch-run.py")
print("----------")

def main():
    if shutdown_at_nighttime():
        print("Shut down at night time")
        sys.exit()


    # Check if any sketches are running
    import subprocess

    proc1 = subprocess.Popen(['ps', 'cax'], stdout=subprocess.PIPE)
    proc2 = subprocess.Popen(['grep', 'processing-java'], stdin=proc1.stdout,
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    proc1.stdout.close() # Allow proc1 to receive a SIGPIPE if proc2 exits.
    out, err = proc2.communicate()

    # if we are running, then make it probable that we keep running as is
    # otherwise, let's fire up a new skethc - DG 25/4/20
    if len(out.decode()) > 0:
        import random
        if random.randint(0,19) > 17:
            print("No change")
            sys.exit()

    import os

    # TODO: select scripts based on this? or dim screen...
    day_part = get_part_of_day(datetime.now().hour)

    sketches = [ 
        'colour_wipes',
        'purple_squares',
        'special_branch_spotlights',
        'floyd_bigger',
        'special_branch_layered_squares',
        'shapes_grid',
        'easel_strokes',
        'led',
        'spots',
        'plain_waves',
        'special_branch_shoreline',
        'coloured_squares',
        'mcferrin_circles',
        'special_branch_natural_squares',
    ]

    sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run'.format(random.choice(sketches))

    now = datetime.now()
    print(now.strftime("%Y-%m-%d %H:%M:%S"))
    print(sketch)
    print('-----')


    # Stop any existing sketches or films
    os.system("kill -9 `ps aux | grep omxplayer | grep -v grep | awk '{print $2}'`")
    os.system("kill -9 `ps aux | grep processing | grep -v grep | awk '{print $2}'`")
    os.system("kill -9 `ps aux | grep PictureFrame | grep -v grep | awk '{print $2}'`")

    os.system(sketch)    

def get_part_of_day(hour):
    return (
        "morning" if 7 <= hour <= 11
    else
        "afternoon" if 12 <= hour <= 17
    else
        "evening" if 18 <= hour <= 21
    else
        "night"
    )

def shutdown_at_nighttime():
    if get_part_of_day(datetime.now().hour) == 'night':
        return True

if __name__ == "__main__":
    main()
