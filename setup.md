create an empty file, 'ssh', in the root of /boot
create a file called 'wpa_supplicant.conf' in the root of /boot:

ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<Insert country code here>

network={
 ssid="<Name of your WiFi>"
  psk="<Password for your WiFi>"
  }
