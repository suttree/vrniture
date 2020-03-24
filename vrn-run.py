import os, random, getopt, sys

def usage():
    print "vrn-run.py -s (startup) -h (help)"

def main(argv):
    try:
	opts, args = getopt.getopt(argv, "hs", ['help', 'startup'])
    except getopt.GetoptError:
	usage()
	sys.exit(2)

    global _startup
    _startup = 0

    for opt, arg in opts:
	if opt in ("-h", "--help"):
	    usage()
	    sys.exit()

	if opt in ("-s", "--startup"):
	    _startup = True

    # hide the cursor
    os.system('DISPLAY=:0 xdotool mousemove 800 800')

    print("vrn-run.py")
    print("----------")


    media = [
	'img-run.py',
	'mov-run.py',
	'sketch-run.py',
    ]

    # chance cubes!
    if (_startup or random.choice([1,2,3,4,5,6]) <= 3):
	print( '/usr/bin/env python /home/pi/src/vrniture/' + random.choice(media) + ' >> /tmp/cron.log 2>&1' )
	os.system( '/usr/bin/env python /home/pi/src/vrniture/' + random.choice(media) + ' >> /tmp/cron.log 2>&1' )

	import datetime
	if (_startup or datetime.datetime.now().hour >= 22):
	    # stop any existing sketches or films
      os.system('killall omxplayer.bin')
	    os.system('killall omxplayer')
	    os.system('killall java')
	    os.system('killall feh')

	    os.system('DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/breathing/" --run >> /tmp/cron.log 2>&1')
    else:
	print 'Pass'

if __name__ == "__main__":
    main(sys.argv[1:]) 
