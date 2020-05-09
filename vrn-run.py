import os, random, getopt, sys, random
from datetime import datetime

def usage():
    print "vrn-run.py -s (startup) -h (help)"

def main(argv):
    try:
	opts, args = getopt.getopt(argv, "hs", ['help', 'startup'])
    except getopt.GetoptError:
	usage()
	sys.exit(2)

    global _startup
    _startup = False

    for opt, arg in opts:
	if opt in ("-h", "--help"):
	    usage()
	    sys.exit()

	if opt in ("-s", "--startup"):
	    _startup = True

    # hide the cursor
    os.system('DISPLAY=:0 xdotool mousemove 800 800')

    # We run via cron every 24 minutes, so this means we only change infrequently
    #if random.randint(0,19) > 17:
    #    print("No change")
    #    sys.exit(0)

    now = datetime.now()
    print(now.strftime("%Y-%m-%d %H:%M:%S"))

    # Breathing at night or a random sketch
    if (datetime.now().hour >= 22 or datetime.now().hour <= 8):
        print('Running the breathing sketch overnight...')
        
        sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/breathing/" --run'
        
        print(sketch)
        print('-----')

        os.system('killall java')
        os.system(sketch)
    else:
        print("Running a random daily sketch")
        #if (_startup or random.choice([1,2,3,4,5,6]) <= 4):
        sketches = [
            'colour_wipes',
            'purple_squares',
            'special_branch_spotlights',
            'floyd_bigger',
            'special_branch_layered_squares',
            'plain_waves',
            'special_branch_shoreline',
            'coloured_squares',
            'mcferrin_circles',
            'special_branch_natural_squares',
        ]

        sketch = 'DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/{0}/" --run >> /tmp/cron.log 2>&1'.format(random.choice(sketches))

        print(sketch)
        print('-----')

        os.system('killall java')
        os.system(sketch)
        #else:
        #    print 'Pass'


if __name__ == "__main__":
    main(sys.argv[1:]) 
