#!/bin/bash

source /.scripts_config

devices=$(ls /dev/disk/by-label/)

for device in $devices; do
    device_path="/dev/disk/by-label/$device"
    target_mount_point="$MOUNT_DIR/$device"

    current_mount_point=$(df -P "$device_path" | awk 'NR==2 {print $6}')

    if [ "$current_mount_point" == "$target_mount_point" ]; then
        echo "[$(now)] Device $device_path is already mounted at $target_mount_point"
        continue
    fi

    if [ -n "$current_mount_point" ]; then
        sudo umount "$device_path"
        echo "[$(now)] Unmounted device $device_path from $current_mount_point"
    fi

    sudo mkdir -p "$target_mount_point"

    sudo mount "$device_path" "$target_mount_point" -O rw,user

    if grep -qs "$target_mount_point" /proc/mounts; then
        echo "[$(now)] Device $device_path successfully mounted at $target_mount_point"
    else
        echo "[$(now)] Failed to mount device $device_path"
    fi
done
