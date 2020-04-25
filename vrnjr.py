#! /usr/bin/env python3

# pip install python-pidfile
from pid import PidFile
import random

print('Starting process')

try:
  with PidFile(piddir='/home/pi/src/vrniture/'):
  print('Process started')

  # Shuffle scripts and run through them one by one
  scripts = ['mov-run.py', 'sketch-run.py', 'img-run.py'] 
  for script in random.sample(scripts, len(scripts)):
    print script

  # Quit and add new crontab entry to being again in 20 minutes?
except pidfile.AlreadyRunningError:
  print('Already running.')
  # Quit and add new crontab entry to being again in 20 minutes?

print('Exiting')
