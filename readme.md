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

// Install feh to the latest version (the rpi default version doesn't include a 'quit on finish' feature)
sudo apt-get --purge remove feh
sudo apt-get install libcurl4-openssl-dev libx11-dev libxt-dev libimlib2-dev libxinerama-dev libjpeg-progs libpng-dev libexif-dev libexif12
pwd
mkdir Feh_Build
cd Feh_Build
wget https://feh.finalrewind.org/feh-3.3.tar.bz2
tar jxvf feh-3.3.tar.bz2 
cd feh-3.3/
make -j4 curl=0 xinerama=0 verscmp=1
sudo make install
sudo ldconfig
