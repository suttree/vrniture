# From http://www.geeks3d.com/hacklab/20160108/how-to-disable-the-blank-screen-on-raspberry-pi-raspbian/

# disable temporarily:
sudo xset s off
sudo xset -dpms
sudo xset s noblank

# disable forever:
# sudo vi/etc/lightdm/lightdm.conf
#
# add to SeatDefaults:
# [SeatDefaults]
# xserver-command=X -s 0 -dpms
