h=`date +%H`                                                                                                     

# Set the sketch root to fit the time of day
if [ $h -lt 12 ]; then
  FILES="/home/pi/src/vrniture/processing/morning/*"
  echo Good morning
elif [ $h -lt 18 ]; then
  FILES="/home/pi/src/vrniture/processing/afternoon/*"
  echo Good afternoon
else
  FILES="/home/pi/src/vrniture/processing/evening/*"
  echo Good evening
fi

# Pick a random sketch and execute it
for f in $FILES; do  FILE="$RANDOM $f" ; done | sort -n | head -n1 | cut -d' ' -f2-
`/usr/local/bin/processing-java --sketch=$FILE --run`
