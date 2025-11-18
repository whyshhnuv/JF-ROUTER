# Disable TR-069 [Does Not Work On New Firmwares] </br>
Any Firmware After 2021 is fully dependent on TR069 for essential services like dimclient. Don't disable Tr069 on them or your router will be bricked.
*Disclaimer: - This is Only for educational purposes, No one is responsible for any type of damage.*

**NOTE : JioCall/Landline/JioSTB/Firmware Auto Update/Changing WiFi settings from MyJio or JioHome apps won't work if TR-069 is disabled.**

1.Gain root access using [this guide](https://github.com/Naitik1208/JIOFIBER/blob/main/Instructions/Get-Root-Access-JF-ONT-Home-Gateway.md)

2.Start telnet on your router ip `192.168.1.1` or `192.168.29.1`

3.Go to the file `/flash/teamf1.cfg.ascii`, `/flash/teamf1.cfg.ascii.bkp` and change following values.

5. **Find** the line
`config.tr69["ManagementServer"][1]["tr69Status"] = "1"`
and **replace** it with
`config.tr69["ManagementServer"][1]["tr69Status"] = "0"`

6. **Find** the line
`config.tr69["ManagementServer"][1]["PeriodicInformEnable"] = "1"`
and **replace** it with
`config.tr69["ManagementServer"][1]["PeriodicInformEnable"] = "0"`

