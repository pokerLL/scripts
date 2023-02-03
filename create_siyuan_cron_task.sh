#! /bin/sh
path=/etc/crontab

sudo echo "3,15 * * * * root `pwd`/sync_siyuan_data_p.sh" >> $path
sudo echo "30 23 * * * root `pwd`/backup_siyuan_note_data_p.sh" >> $path

sudo crontab /etc/crontab
