#Script mean for Factory Reset
#!/bin/sh

    #Remove third party param file
    rm -rf /flash/thirdparty/thirdparty.param

        #Remove tr69 config files
        rm -rf /flash/tr69
        rm -rf /flash/connectionSucceeded

        #Remove https files
        rm -rf /flash/https*
        rm -rf /flash/TLSCERT

        #Remove omci parameter configured xml files
        rm -rf /flash/omci_xml/xml_params

        #Remove omci xml command files
        rm -rf /flash/omci_xml/xml_commands

        touch /tmp/softRebootTrigger

        #copying ont_dc config files
        cp -rf /pfrm2.0/etc/ont_dc.conf_default /pfrm2.0/etc/ont_dc.conf

        #Remove the file Agent Connected info
                rm -rf /flash/AGENT_CONNECTED

        #A sign to identify whether factory reset has been done or not.
        touch /flash/factoryreset.txt
        #Enable Mesh after factory Reset for JCOW401
    if [ -e /pfrm2.0/BRCM_MESH_ENABLED ] ; then
        touch /flash/BRCM_MESH_ENABLED
    fi

        #file to be used for GUI redirection to change password page
                touch /flash/FcDef

    #Remove the mcpd.conf
    rm -rf /flash/mcpd.conf

killall dimclient

rm /tmp/tr69client.log
/pfrm2.0/bin/dimclient -l/pfrm2.0/etc/tr69.logcfg -p/tmp/cpe3 -b7545 -d::/128 -f /pfrm2.0/etc/tr69.cfg &
