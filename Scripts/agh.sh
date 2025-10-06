#!/bin/sh

# ==================================
# CONFIGURATION AND LOGGING
# ==================================
LOG_FILE="/tmp/agh_boot.log" # Log everything to /tmp
IPTABLES_BIN="/pfrm2.0/bin/iptables" # Use the custom binary

# Log header
echo "--- AGH Script Start: $(date) ---" >> $LOG_FILE


# ==================================
# 1. FUNCTION DEFINITIONS
# ==================================

# Function to run and monitor AdGuard Home
agh_watchdog() {
    # Check for AGH binary
    if [ ! -x "/mnt/usb/AdGuard" ]; then
        echo "FATAL: /mnt/usb/AdGuard not found or not executable. Aborting watchdog." >> $LOG_FILE
        return 1
    fi
    
    while true; do
        # Check if the AdGuard process is running
        if ! ps | grep -v "grep" | grep -q "[A]dGuard"; then
            echo "AGH not running. Attempting to restart..." >> $LOG_FILE
            
            # Navigate to the correct directory for AGH config access
            cd /mnt/usb
            
            # Start AdGuard Home in the background
            ./AdGuard &
            echo "AGH launched. PID: $!" >> $LOG_FILE
        fi
        sleep 15
    done
}

# Function to repeatedly set the LAN DNS and ensure firewall rule exists
dns_and_firewall_updater() {
    while true; do
        # 1. Force nameserver to localhost
        echo "nameserver 127.0.0.1" > /etc/resolv/resolv.conf.IF1

        # 2. Ensure firewall rule for AGH web UI (port 81) exists.
        "$IPTABLES_BIN" -C INPUT -p tcp --dport 81 -j ACCEPT 2>/dev/null || "$IPTABLES_BIN" -I INPUT 1 -p tcp --dport 81 -j ACCEPT
        
        sleep 2
    done
}


# ==================================
# 2. MAIN SCRIPT EXECUTION
# ==================================

# Setup the mount point
mkdir -p /mnt/usb

# Check if drive is already mounted
if mount | grep -q "on /mnt/usb"; then
    echo "Drive is already mounted." >> $LOG_FILE
else
    # Attempt to mount the drive
    echo "Attempting to mount /dev/disk/by-label/Router..." >> $LOG_FILE
    
    # Give the system time for the drive to initialize
    sleep 3
    
    mount /dev/disk/by-label/Router /mnt/usb
    
    # CRITICAL: Check the exit code of the mount operation
    if [ $? -ne 0 ]; then
        echo "ERROR: Mount FAILED. Script is exiting." >> $LOG_FILE
        exit 1 
    fi
    echo "Mount successful." >> $LOG_FILE
fi

# Start the watchdog and updater functions as background processes
agh_watchdog &
echo "AGH Watchdog launched in background (PID: $!)." >> $LOG_FILE

dns_and_firewall_updater &
echo "DNS Updater launched in background (PID: $!)." >> $LOG_FILE

echo "--- AGH Script End: $(date) ---" >> $LOG_FILE