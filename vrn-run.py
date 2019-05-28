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
]

sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run'.format(random.choice(sketches))

print(sketch)
os.system(sketch)    
