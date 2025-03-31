#  Shell Script to Check Disk Space Usage on Multiple Servers via SSH

#!/bin/bash

# List of remote servers (Replace with actual server IPs or hostnames)
SERVERS=("server1.example.com" "server2.example.com" "192.168.1.10")

# Threshold for disk space usage (80% in this case)
THRESHOLD=80

# Log file for recording disk usage status
LOG_FILE="/var/log/disk_space_check.log"

# SSH user (replace with actual user)
USER="your_ssh_user"

# Function to check disk space on a remote server
check_disk_space() {
    local SERVER=$1
    echo "Checking disk space on $SERVER..."
    
    # Get the disk usage percentage for root (/) partition
    USAGE=$(ssh -o BatchMode=yes -o ConnectTimeout=5 "$USER@$SERVER" "df -h / | awk 'NR==2 {print \$5}' | tr -d '%'")
    
    # Check if SSH was successful
    if [[ -z "$USAGE" ]]; then
        echo "$(date): ERROR - Unable to connect to $SERVER" | tee -a "$LOG_FILE"
        return
    fi

    # Log and alert if usage exceeds the threshold
    if (( USAGE > THRESHOLD )); then
        echo "$(date): ALERT - Disk usage on $SERVER is at ${USAGE}%. Exceeds threshold of ${THRESHOLD}%!" | tee -a "$LOG_FILE"
    else
        echo "$(date): OK - Disk usage on $SERVER is ${USAGE}%." | tee -a "$LOG_FILE"
    fi
}

# Iterate through all servers and check disk space
for SERVER in "${SERVERS[@]}"; do
    check_disk_space "$SERVER"
done
