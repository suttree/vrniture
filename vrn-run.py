#! /usr/bin/env python

import os
import random

# TODO: run via cron every 5 minutes, and use random.choice() to either quit or run


# TODO: find a cleaner way to do this
os.system('killall java')

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
]

sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run'.format(random.choice(sketches))

print(sketch)
os.system(sketch)    
