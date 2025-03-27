# Shell Script to Check Server Uptime and Log if Less Than 24 Hours

#!/bin/bash

# Log file for uptime check
LOG_FILE="/var/log/server_uptime.log"

# Get uptime in minutes (convert days, hours, and minutes into total minutes)
UPTIME_MINUTES=$(awk '{print $1}' /proc/uptime | awk '{print int($1 / 60)}')

# Convert 24 hours into minutes (1440 minutes)
THRESHOLD_MINUTES=1440

# Check if uptime is less than 24 hours
if [[ "$UPTIME_MINUTES" -lt "$THRESHOLD_MINUTES" ]]; then
    echo "$(date): Server uptime is less than 24 hours (${UPTIME_MINUTES} minutes). Logging this event." | tee -a "$LOG_FILE"
else
    echo "$(date): Server has been running for more than 24 hours (${UPTIME_MINUTES} minutes). No action needed."
fi
