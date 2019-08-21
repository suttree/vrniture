#! /usr/bin/env python

import sys
from datetime import datetime

def main():
    if shutdown_at_nighttime():
        sys.exit()

    import random

    # We run via cron every 5 minutes, so this means we only change infrequently
    if random.randint(0,19) > 16:
        print("No change")
        sys.exit()

    import os

    # TODO: select scripts based on this? or dim screen...
    day_part = get_part_of_day(datetime.now().hour)

    sketches = [ 
        'special_branch_perlin_shapes',
        'stare',
        'maylers',
        'purple_squares',
        'led',
        'shapes',
        'special_branch_layered_squares',
        'special_branch_layers',
        'special_branch_shoreline',
        'special_branch_stage_lighting',
        'coloured_squares',
        'special_branch_spotlights',
        'plain_square',
        'plain_waves',
        'special_branch_natural_squares',
        'triad_lines',
        'colour_wipes',
        'special_branch_coloured_spotlights',
        'mcferrin_circles',
        'breathing',
    ]

    sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run'.format(random.choice(sketches))

    print(sketch)
    os.system('killall java')
    os.system(sketch)    

def brightness():
    return True

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
        if random.randint(0, 10) < 8:
            sys.exit()

if __name__ == "__main__":
    main()
