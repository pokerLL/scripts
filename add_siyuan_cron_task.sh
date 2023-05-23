#!/bin/bash

source /.scripts_config

# Command and parameters
command="/bin/bash $BASE_DIR/backup_siyuan_container_data.sh"
params=("$@")

for param in "${params[@]}"
do
    cron_job="30 4 * * * root $command $param"

    if grep -Fxq "$cron_job" /etc/crontab; then
        echo "Cron job already exists: $cron_job"
    else
        echo "Adding cron job: $cron_job"
        echo "$cron_job" | sudo tee -a /etc/crontab > /dev/null
    fi
done

crontab /etc/crontab
