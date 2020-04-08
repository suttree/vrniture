#! /usr/bin/env python

import sys, os
from datetime import datetime

# hide the cursor
os.system('DISPLAY=:0 xdotool mousemove 800 800')

print("sketch-run.py")
print("----------")

def main():
    if shutdown_at_nighttime():
        sys.exit()

    import random

    # We run via cron every 24 minutes, so this means we only change infrequently
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
    os.system('killall omxplayer')
    os.system('killall java')
    os.system('killall feh')

    os.system(sketch)    

def get_part_of_day(hour):
    return (
        "morning" if 5 <= hour <= 11
    else
        "afternoon" if 12 <= hour <= 17
    else
        "evening" if 18 <= hour <= 22
    else
        "night"
    )

def shutdown_at_nighttime():
    if get_part_of_day(datetime.now().hour) == 'night':
        return True

if __name__ == "__main__":
    main()