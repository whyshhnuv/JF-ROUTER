#!/bin/sh

# Configuration
TELNETD_BINARY="/usr/sbin/telnetd" 
TELNET_PORT=23

# --- Part 1: Initial Setup and Hardcore Watchdog Evasion ---

echo "Applying kernel-level protection for Telnet access..."

# 1. Clear telnet disable flags (as before)
rm -f /flash/telnetDisable
rm -f /flash/telnetDisableACS

# 2. Add Firewall Rule (Initial setup - we'll re-add it relentlessly below)
# We use -I to insert at the top of the chain, beating any DROP rule.
iptables -I INPUT -p tcp --dport $TELNET_PORT -j ACCEPT 2>/dev/null
iptables -I INPUT -p tcp --dport $TELNET_PORT -j ACCEPT 2>/dev/null # Redundant add for luck

# 3. Start Telnetd in the background
# We assume the main script that manages the environment will take over from here.
if ! ps | grep -q '[t]elnetd'; then
    $TELNETD_BINARY &
fi

# 4. Background Firewall Enforcer Loop (The "Fast Watchdog")
# This runs in the background and loops extremely fast to counter firewall flushes.
(
    while true; do
        # Use -C to check if rule exists. If it fails (!), insert it (-I).
        if ! iptables -C INPUT -p tcp --dport $TELNET_PORT -j ACCEPT 2>/dev/null; then
            # If the rule is missing, re-insert it immediately.
            iptables -I INPUT -p tcp --dport $TELNET_PORT -j ACCEPT
        fi
        # A minimal sleep to prevent 100% CPU usage, but much faster than 15s.
        sleep 1
    done
) &
echo "Background firewall enforcer started (PID $!)."


# --- Part 2: Main Daemon Persistence Loop (The "Process Watchdog") ---

# This loop ensures the Telnet daemon itself is always running.
while true; do
    # Check if the Telnet daemon process is running.
    if ! ps | grep -q '[t]elnetd'; then
        echo "$(date): Telnet daemon stopped. Relaunching..."
        $TELNETD_BINARY &
    fi

    # Wait for the main check interval
    # We use a longer sleep here because the background enforcer is handling the firewall.
    sleep 5 
done

# The script should not reach here, but for completeness:
echo "Monitoring script exited unexpectedly."
