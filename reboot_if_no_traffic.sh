#!/bin/bash
###############
# reboot_if_no_traffic.sh
###############

# Reboots this computer after its been up for at least 3 days and
# there doesnt happen to be any traffic on the network, other than
# that from this computer.  If theres traffic then it keeps trying
# every hour.  It runs the script local_traffic_p.sh to determine if there
# is currently network traffic.  This script needs to be run as sudo.

reboot_if_no_traffic() {
    # Uptime threshold in days
    local uptime_threshold=3

    while true; do
        # Get the uptime in days
        local uptime_days=$(awk '{print int($1/86400)}' /proc/uptime)

        if [[ $uptime_days -ge $uptime_threshold ]]; then
            echo "Uptime is over $uptime_threshold days. Checking network activity using local_traffic_p.sh."

            if local_traffic_p.sh | grep -q "No significant network traffic"; then
                echo "No network activity. Initiating reboot."
                sudo reboot
                break
            else
                echo "Network is active. Will check again in an hour."
            fi
        else
            echo "Uptime is under $uptime_threshold days. Will check again in an hour."
        fi

        sleep 3600  # Sleep for one hour
    done
}

reboot_if_no_traffic()
