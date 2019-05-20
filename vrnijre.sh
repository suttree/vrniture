h=`date +%H`                                                                                                     

# execute the processing-java script based on time of day
if [ $h -lt 12 ]; then
  echo Good morning
elif [ $h -lt 18 ]; then
  echo Good afternoon
else
  echo Good evening
fi
