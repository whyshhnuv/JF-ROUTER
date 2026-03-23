# Disable TR-069 </br>
Any Firmware After 2021 is fully dependent on TR069 for essential services like dimclient. Don't disable Tr069 on them or your router will be bricked.
*Disclaimer: - This is Only for educational purposes, No one is responsible for any type of damage.*

1.Gain root access using [this guide](https://github.com/Naitik1208/JIOFIBER/blob/main/Instructions/Get-Root-Access-JF-ONT-Home-Gateway.md)

2.Start telnet on your router ip `192.168.1.1` or `192.168.29.1`

3. Download [this file](https://github.com/Naitik1208/JF-ROUTER/blob/main/Scripts/dimclient)

4. Make directory /scripts or just copy that file directly after deleting actual dimclient or you may backup and rename original and use the file I made.

5. Then save it, and move to `pfrm2.0/bin/dimclient` using command `mv /scripts/dimclient /pfrm2.0/bin/dimclient`

6. Then `chmod +x /pfrm2.0/bin/dimclient`

7. And done simple as that just verify using `cat /pfrm2.0/bin/dimclient`

8. If changes made then you are good to go and have disabled TR069 on any firmware version \n
