# Shell Script to Monitor Network Connectivity and Log Failures

#!/bin/bash

# Server to monitor (Replace with the actual IP or domain)
SERVER="8.8.8.8"

# Log file
LOG_FILE="/var/log/network_monitor.log"

# Ping the server and check if it's reachable
ping -c 3 $SERVER > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "$(date): Network failure - $SERVER is unreachable" >> $LOG_FILE
fi
