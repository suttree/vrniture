# VRNJR

Digital art furniture.

Using a Raspberry Pi and Processing to create generative art for the home.

![alt text](https://github.com/suttree/vrniture/blob/master/vrnjr.jpg?raw=true)

---

### Notes / todos / misc
Add display_rotate=2 to boot/config.txt to rotate the screen 180

To position the mouse cursor off screen:
sudo apt-get install xdotool
xdotool mousemove 500 500

To run a slideshow of images, we tried feh but it would silently fail and needed an update from source to enable an option where it would quit once it was finished :~/

To run a slideshow of movies, we tried omx, omx-wrapper, vlc, mplayer, then back to omxplayer with some better bash scripting

To stop screensaver, and hide the mouse cursor:
sudo vi /etc/lightdm/lightdm.conf

// don't sleep the screen, and hide the cursor
xserver-command=X -s 0 dpms
xserver-command = X -nocursor

// Ditch feh for pi3d
https://github.com/pi3d/pi3d.github.com

--

### Removing power/voltage warnings
/boot/config.txt
avoid_warnings=1

sudo apt remove lxpanel


--

#### Install & setup notes 2024
1. Download and install processing
2. Copy processing-java to /usr/local/bin
3. Install java - sudo apt install default-jdk


Run from inside the processing source folder /home/duncan/src/processing/

 ./processing-java --sketch="/home/duncan/src/vrniture/processing/breathing/" --run

export CLASSPATH=/path/to/your/java/application.jar
