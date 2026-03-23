# DOWNGRADE FIRMWARE
NOTE:-This is only for educational purposes. 
If your router is bricked or don't work then I am not responsible for it. 
Successfully tested on multiple JCOW404 and JCOW411. <br/>
1. Get Root Access using [this guide](https://github.com/Naitik1208/JF-ROUTER/blob/main/Instructions/Get-Root-Access-JF-ONT.md) <br/>
2. Download firmware from [here](https://github.com/Naitik1208/JF-ROUTER/tree/main/Firmware)<br/>
3. Upload firmware and sig file on maintenance --> firmware upgrade page.<br/>
4. Run mkdir -p /tmp/firmCheckRes.txt in telnet session. <br/>
5. Upgrade button will be enabled on admin page click it and wait for router to reboot and enjoy.
<br/>
Some services like JIO app and Voip will not work for a few days.<br/>
For me it started working when my firmware was updated to 2.30.2 automatically by TR-069. <br/>
