#!/bin/bash

# This script checks to see whether there is local network traffic from/to other computers on the specified LAN

# Network Interface to monitor
INTERFACE="eth0"

# Server's IP Address - replace with your server's IP address
SERVER_IP="192.168.0.1"

# Duration to capture packets (in seconds)
DURATION=10

# Temporary file to store tcpdump output
TMP_FILE="/tmp/tcpdump_output.txt"

# Capture traffic excluding the server's own IP
sudo timeout ${DURATION} tcpdump -i ${INTERFACE} -n "not host ${SERVER_IP}" -w ${TMP_FILE}

# Check if the capture file is empty or not
if [[ -s ${TMP_FILE} ]]; then
    echo "Network traffic detected from/to other computers."
else
    echo "No significant network traffic detected from/to other computers."
fi

# Clean up
rm ${TMP_FILE}

