#!/bin/sh

# Define the target configuration file for the 5GHz network and 2.4GHz

CONF_FILE_5G="/tmp/wl1_hapd.conf"
CONF_FILE_4G="/tmp/wl0_hapd.conf" 
sleep 20
# Patch the 5GHz config file to enable WPA2/WPA3 transitional mode.
# We make both changes in a single, efficient command.
sed -i -e 's/wpa_key_mgmt=WPA-PSK/wpa_key_mgmt=WPA-PSK SAE/' -e 's/ieee80211w=0/ieee80211w=1/' "$CONF_FILE_5G"

sed -i -e 's/wpa_key_mgmt=WPA-PSK/wpa_key_mgmt=WPA-PSK SAE/' -e 's/ieee80211w=0/ieee80211w=1/' "$CONF_FILE_4G"
# Perform a "Hard Restart" on the 5GHz hostapd service.
# First, kill the currently running process.
kill $(ps w | grep "$CONF_FILE_5G" | grep -v grep | awk '{print $1}')
kill $(ps w | grep "$CONF_FILE_4G" | grep -v grep | awk '{print $1}')

# Give the system a moment to release the Wi-Fi hardware.
sleep 3

# Restart the service from scratch using the newly patched config file.
hostapd -B "$CONF_FILE_5G"

hostapd -B "$CONF_FILE_4G"

exit 0
