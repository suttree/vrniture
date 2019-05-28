#! /usr/bin/env python

import os
import random

sketches = [ 
    'stare',
    'maylers',
    'purple_squares',
    'led',
]

sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run'.format(random.choice(sketches))

print(sketch)
os.system('killall java')
os.system(sketch)    
