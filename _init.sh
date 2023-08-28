sudo bash /scripts-collection/auto_mount_disk.sh
sudo systemctl stop frpc && sudo systemctl start frpc
sudo systemctl stop docker && sudo systemctl start docker
