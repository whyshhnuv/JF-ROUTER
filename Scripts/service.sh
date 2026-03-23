#
# --- Self-Contained Telnet Service Watchdog ---
# This block runs in the background and ensures Telnet and all
# associated rules and settings are active.
rm /flash/telnetDisableACS
    # Start the infinite monitoring loop.
    while true; do
            /pfrm2.0/bin/iptables -I fwInBypass -p tcp --dport 23 -m ifgroup --ifgroup-in 0x1/0x1 -j ACCEPT
        # Check if the 'telnetd' process is running.
        if ! ps | grep -v "grep" | grep -q "telnetd"; then
        
            # If 'telnetd' is NOT running, execute all restoration commands:
            
            # 1. Start the Telnet daemon.
            /usr/sbin/telnetd

            # 2. Insert the firewall rule to allow Telnet access.
            /pfrm2.0/bin/iptables -I fwInBypass -p tcp --dport 23 -m ifgroup --ifgroup-in 0x1/0x1 -j ACCEPT

            # 3. Set/reset the root password to 'password'.
            echo -e "password\npassword" | passwd root
            
        fi 
# End of the command block.

        # Wait for 15 seconds before checking again.
        sleep 15
        
    done 
# Loop repeats forever.


