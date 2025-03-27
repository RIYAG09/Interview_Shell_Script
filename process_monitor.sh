# Shell Script to Monitor and Restart Processes

#!/bin/bash

# Define the list of processes to monitor
PROCESSES=("nginx" "mysql" "apache2")  # Add process names as needed

# Log file for recording process restarts
LOG_FILE="/var/log/process_monitor.log"

# Function to check and restart processes
check_and_restart() {
    for process in "${PROCESSES[@]}"; do
        # Check if the process is running
        if ! pgrep -x "$process" > /dev/null; then
            echo "$(date): $process is not running! Restarting..." | tee -a "$LOG_FILE"
            
            # Restart the process
            sudo systemctl restart "$process"

            # Verify if it restarted successfully
            if pgrep -x "$process" > /dev/null; then
                echo "$(date): Successfully restarted $process" | tee -a "$LOG_FILE"
            else
                echo "$(date): Failed to restart $process" | tee -a "$LOG_FILE"
            fi
        fi
    done
}

# Run the function
check_and_restart
