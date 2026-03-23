#!/bin/sh
mkdir -p /tmp/agh
ip link set lo up

#DNS CHANGE LOOP
(
    while true; do
        echo "nameserver 127.0.0.1" > /etc/resolv/resolv.conf.IF1
        echo "nameserver ::1" >> /etc/resolv/resolv.conf.IF1

        SEARCH_PARAM="--dport 81 -m ifgroup --ifgroup-in 0x1/0x1"
        if ! /pfrm2.0/bin/iptables -S fwInBypass 2>/dev/null | grep -q -- "$SEARCH_PARAM"; then
            /pfrm2.0/bin/iptables -I fwInBypass -p tcp --dport 81 -m ifgroup --ifgroup-in 0x1/0x1 -j ACCEPT
        fi
        sleep 10
    done
) &

# --- Start Final, Unbreakable AdGuard Supervisor Loop ---
(
  # Configuration
  AGH_COMMAND="/data/AdGuard --work-dir /tmp/agh --config /data/AdGuardHome.yaml"
  AGH_CHECK_STRING="/data/AdGuard"

  while true; do
   
 # Monitor AGH: If AdGuard Home crashes, restart it
    AGH_PROCESS_CHECK=$(ps w | grep "$AGH_CHECK_STRING" | grep -v grep)
    if [ -z "$AGH_PROCESS_CHECK" ]; then
      echo "[SUPERVISOR] AdGuard Home is not running. Restarting with Proxy..."
      $AGH_COMMAND &
    fi

    sleep 15
  done
) &
