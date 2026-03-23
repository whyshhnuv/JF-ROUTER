# Disable TR-069 [Does Not Work On New Firmwares] </br>
Any Firmware After 2021 is fully dependent on TR069 for essential services like dimclient. Don't disable Tr069 on them or your router will be bricked.
*Disclaimer: - This is Only for educational purposes, No one is responsible for any type of damage.*

1.Gain root access using [this guide](https://github.com/Naitik1208/JIOFIBER/blob/main/Instructions/Get-Root-Access-JF-ONT-Home-Gateway.md)

2.Start telnet on your router ip `192.168.1.1` or `192.168.29.1`

3. make a custom script named dimclient
4. Paste this in script
`#!/bin/sh
# 1. Create the 'Ready' files the Web Panel is waiting for
touch /tmp/trInitDone.txt
touch /tmp/trThirdPartyInitDone.txt
touch /tmp/firewallInitialized
touch /tmp/internetUp
touch /tmp/connSuccess

# 2. Force the Database state
/pfrm2.0/bin/sqlite3 /tmp/system.db "UPDATE tr69Config SET tr69status='1';"

# 3. Satisfy the SHM check (Optional but recommended)
# We use the 'ipcmk' command if available, otherwise just create a dummy file
# that matches the expected SHM key path if it's file-based.
mkdir -p /tmp/cpe3

# 4. Stay alive for the Hardware Watchdog
while true; do
    # Periodic 'Ready' refresh in case a service deletes them
    touch /tmp/trInitDone.txt
    sleep 30
done
`
6. Then save it, and move to `pfrm2.0/bin/dimclient` using command mv location to this dimclient you created /pfrm2.0/bin/dimclient`
7. Then `chmod +x /pfrm2.0/bin/dimclient` 
8. And done simple as that just verify using `cat /pfrm2.0/bin/dimclient`
9. If changes made then you are good to go and have disabled TR069 on any firmware version 
