#!/bin/sh

# Configuration
VSFTPD_CONF="/flash/vsftpd.conf"
IPTABLES_CHAIN="fwInBypass"
# The full iptables rule to check/add. Note: -I inserts, -C checks.
IPTABLES_RULE="-p tcp --dport 21 -m ifgroup --ifgroup-in 0x1/0x1 -j ACCEPT"
CHECK_INTERVAL_SECONDS=60 # How often (in seconds) to perform the checks

echo "Starting periodic FTP service and firewall rule checker..."
echo "Checking every $CHECK_INTERVAL_SECONDS seconds."

while true; do
    echo "--- $(date) ---"

    # 1. Check and enable vsftpd (FTP server)
    # Replaced pgrep with ps and grep
    if ps w | grep "vsftpd" | grep -v "grep" > /dev/null; then
        echo "vsftpd is already running."
    else
        echo "vsftpd not running. Attempting to start..."
        # It's generally not needed to pkill if it's not running,
        # but if you want to ensure a fresh start even if it was stuck, uncomment below.
        # pkill vsftpd > /dev/null 2>&1
        vsftpd "$VSFTPD_CONF" &
        if [ $? -eq 0 ]; then
            echo "vsftpd started successfully with config: $VSFTPD_CONF"
        else
            echo "ERROR: Failed to start vsftpd. Check configuration and logs."
        fi
    fi

    # 2. Check and add firewall rule for FTP (port 21)
    # Using iptables -C to check if the rule exists.
    # We redirect output to /dev/null as -C will print if the rule doesn't match.
    if iptables -C "$IPTABLES_CHAIN" $IPTABLES_RULE > /dev/null 2>&1; then
        echo "Firewall rule for FTP (port 21) already exists in chain '$IPTABLES_CHAIN'."
    else
        echo "Firewall rule for FTP (port 21) not found in chain '$IPTABLES_CHAIN'. Attempting to add..."
        # Using -I to insert the rule at the beginning of the chain, as per your original script.
        iptables -I "$IPTABLES_CHAIN" $IPTABLES_RULE
        if [ $? -eq 0 ]; then
            echo "Firewall rule added successfully: iptables -I $IPTABLES_CHAIN $IPTABLES_RULE"
        else
            echo "ERROR: Failed to add firewall rule. Check iptables permissions or syntax."
        fi
    fi

    echo "Next check in $CHECK_INTERVAL_SECONDS seconds..."
    sleep "$CHECK_INTERVAL_SECONDS"
done

