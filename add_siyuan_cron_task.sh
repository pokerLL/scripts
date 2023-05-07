#!/bin/bash

# Command and parameters
command="sudo bash $(readlink -f $(dirname "$0"))/backup_siyuan_container_data.sh"
params=("$@")

# Add a cron job for each parameter
for param in "${params[@]}"
do
    # Cron job
    cron_job="30 4 * * * root $command $param"

    # Check if the cron job already exists
    if sudo grep -Fxq "$cron_job" /etc/crontab; then
        echo "Cron job already exists: $cron_job"
    else
        echo "Adding cron job: $cron_job"
        echo "$cron_job" | sudo tee -a /etc/crontab > /dev/null
    fi
done

# Update crontab
sudo crontab /etc/crontab
