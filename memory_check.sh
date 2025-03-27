# Shell Script to Check Free Memory and Alert If Below Threshold

#!/bin/bash

# Set memory threshold percentage (Adjust as needed)
THRESHOLD=10

# Get total and available memory in MB
TOTAL_MEM=$(free -m | awk '/^Mem:/{print $2}')
AVAILABLE_MEM=$(free -m | awk '/^Mem:/{print $7}')

# Calculate available memory percentage
AVAILABLE_PERCENT=$((AVAILABLE_MEM * 100 / TOTAL_MEM))

# Log file location
LOG_FILE="/var/log/memory_check.log"

# Check if available memory is below threshold
if [ "$AVAILABLE_PERCENT" -lt "$THRESHOLD" ]; then
    MESSAGE="ALERT: Low Memory! Only $AVAILABLE_PERCENT% available."
    
    # Print alert to user
    echo "$MESSAGE"
    
    # Log the alert
    echo "$(date): $MESSAGE" >> "$LOG_FILE"
    
    # Optional: Send an email alert (Requires `mail` command to be installed)
    # echo "$MESSAGE" | mail -s "Low Memory Warning" user@example.com
fi
