import os, random, getopt, sys, subprocess

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

    print("vrn-run.py")
    print("----------")


    media = [
      'img-run.py',
      'mov-run.py',
      'sketch-run.py',
      'sketch-run.py', # stack the deck
      'sketch-run.py', # stack the deck again
    ]

    import datetime
    if (datetime.datetime.now().hour >= 22 or datetime.datetime.now().hour <= 8):
        print('Running the breathing sketch overnight...')
        clean_up()
        #os.system('DISPLAY=:0 /usr/local/bin/processing-java --sketch="/home/pi/src/vrniture/processing/breathing/" --run')
        subprocess.Popen(['/usr/local/bin/processing-java', '--sketch="/home/pi/src/vrniture/processing/breathing/', '--run' ])
    else:
        # chance cubes!
        if (_startup or random.choice([1,2,3,4,5,6]) <= 4):
            clean_up()
            print( '/usr/bin/env python3 /home/pi/src/vrniture/' + random.choice(media) )
            #os.system( '/usr/bin/env python3 /home/pi/src/vrniture/' + random.choice(media) )
            subprocess.Popen([ '/usr/bin/env', 'python3', '/home/pi/src/vrniture/' + random.choice(media) ])
        else:
            print 'Pass'
    sys.exit(0)

def clean_up():
    os.system("kill -9 `ps aux | grep mov-run.sh | grep -v grep | awk '{print $2}'`")
    os.system("kill -9 `ps aux | grep processing | grep -v grep | awk '{print $2}'`")
    os.system("kill -9 `ps aux | grep java | grep -v grep | awk '{print $2}'`")
    os.system("kill -9 `ps aux | grep PictureFrame | grep -v grep | awk '{print $2}'`")
    os.system("kill -9 `ps aux | grep omxplayer | grep -v grep | awk '{print $2}'`")

if __name__ == "__main__":
    main(sys.argv[1:]) 
