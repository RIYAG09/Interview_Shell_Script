# Shell Script to Download the Latest Backup File from a Remote Server and Log the Download Time

#!/bin/bash

# Remote server details
REMOTE_USER="your_user"
REMOTE_HOST="your.remote.server"
REMOTE_DIR="/path/to/backup/directory"
LOCAL_DIR="/path/to/local/backup/storage"
LOG_FILE="/var/log/backup_download.log"

# Find the latest backup file on the remote server
LATEST_BACKUP=$(ssh ${REMOTE_USER}@${REMOTE_HOST} "ls -t ${REMOTE_DIR} | head -1")

# Check if a backup file was found
if [[ -z "$LATEST_BACKUP" ]]; then
    echo "$(date): No backup files found on the remote server!" | tee -a "$LOG_FILE"
    exit 1
fi

# Download the latest backup file
scp ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"$LATEST_BACKUP" "$LOCAL_DIR"

# Verify if the file was successfully downloaded
if [[ -f "${LOCAL_DIR}/${LATEST_BACKUP}" ]]; then
    echo "$(date): Successfully downloaded $LATEST_BACKUP from $REMOTE_HOST" | tee -a "$LOG_FILE"
else
    echo "$(date): Failed to download $LATEST_BACKUP from $REMOTE_HOST" | tee -a "$LOG_FILE"
fi
