#!/bin/sh
#DNS CHANGE LOOP
(
    while true; do
        echo "nameserver 127.0.0.1" > /etc/resolv/resolv.conf.IF1
        sleep 10
    done # The loop repeats forever.

) &
# --- Start Final, Unbreakable NextDNS Supervisor Loop ---
# This entire block is run in the background. It is launched by the system's
# init process, making it a true daemon immune to login/logout.
(
  # The exact command that works for you
  NEXTDNS_COMMAND="/flash/nextdns run -profile "
  PID_FILE="/var/run/nextdns.pid"

  # The infinite supervisor loop
  while true; do
    # Use the classic, guaranteed 'ps | grep' to check if the process is running
    PROCESS_CHECK=$(ps w | grep "/flash/nextdns" | grep -v grep)

    # If the process is NOT running...
    if [ -z "$PROCESS_CHECK" ]; then
      # ...first, clean up the stale lock file...
      rm -f "$PID_FILE"

      # ...then, restart the service in the background.
      $NEXTDNS_COMMAND &
    fi

    # Check again in 15 seconds
    sleep 15
  done
) &


