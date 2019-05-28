#! /usr/bin/env python

import os
import random

sketches = [ 
    'stare',
    'maylers',
    'etc'
]

sketch = '/usr/local/processing-java --sketch=/home/pi/src/vrnijure/{0} --run'.format(random.choice(sketches))
#print(sketch)
#os.system(sketch)    
