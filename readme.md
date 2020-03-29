Add display_rotate=2 to boot/config.txt to rotate the screen 180

To position the mouse cursor off screen:
sudo apt-get install xdotool
xdotool mousemove 500 500

To run a slideshow of images:
sudo apt-get install feh

To run a slideshow of movies:
#sudo apt-get update && sudo apt-get install -y libdbus-1-dev
#sudo reboot
#pip3 install omxplayer-wrapper
# omx crashes a lot..., vlc has crazy command line options but feels a bit odd

sudo apt-get install mplayer
mplayer -fs -shuffle -playlist playlist.txt


To stop screensaver, and hide the mouse cursor:
sudo vi /etc/lightdm/lightdm.conf

# don't sleep the screen, and hide the cursor
xserver-command=X -s 0 dpms
xserver-command = X -nocursor
