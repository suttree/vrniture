#! /usr/bin/env python

import sys
from datetime import datetime

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
        'led',
        'plain_waves',
        'special_branch_shoreline',
        'coloured_squares',
        'mcferrin_circles',
        'special_branch_natural_squares',
    ]

    sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run'.format(random.choice(sketches))

    now = datetime.datetime.now()
    print(now.strftime("%Y-%m-%d %H:%M:%S"))
    print(sketch)
    print('-----')
    os.system('killall java')
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
