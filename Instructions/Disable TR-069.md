# Disable TR-069 [Does Not Work On New Firmwares] </br>
Any Firmware After 2021 is fully dependent on TR069 for essential services like dimclient. Don't disable Tr069 on them or your router will be bricked.
*Disclaimer: - This is Only for educational purposes, No one is responsible for any type of damage.*

1.Gain root access using [this guide](https://github.com/Naitik1208/JIOFIBER/blob/main/Instructions/Get-Root-Access-JF-ONT-Home-Gateway.md)\n

2.Start telnet on your router ip `192.168.1.1` or `192.168.29.1`\n
3. Download [this file]()\n
4. Then save it, and move to `pfrm2.0/bin/dimclient` using command mv location to this dimclient you created /pfrm2.0/bin/dimclient`\n
5. Then `chmod +x /pfrm2.0/bin/dimclient` \n
6. And done simple as that just verify using `cat /pfrm2.0/bin/dimclient` \n
7. If changes made then you are good to go and have disabled TR069 on any firmware version \n
