#! /usr/bin/env python

# TODO: run via cron every 5 minutes, and use random.choice() to either quit or run

import sys
from datetime import datetime

def main():
    if shutdown_at_nighttime():
        sys.exit()

    import os
    import random

    # TODO: select scripts based on this? or dim screen...
    day_part = get_part_of_day(datetime.now().hour)

    sketches = [ 
        'stare',
        'maylers',
        'purple_squares',
        'led',
        'back2',
        'circles',
        'shapes',
        'shapes2',
        'special_branch_layered_squares',
        'special_branch_layers',
        'special_branch_natural_squares',
        'special_branch_perlin_shapes',
        'special_branch_shoreline',
        'special_branch_stage_lighting',
        'special_branch_terrain',
        'coloured_squares',
        'special_branch_spotlights',
        'plain_square',
        'plain_waves',
        'triad_lines',
    ]

    sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run'.format(random.choice(sketches))

    print(sketch)
    os.system(sketch)    

def cleanup():
    # TODO: find a cleaner way to do this
    os.system('killall java')

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
