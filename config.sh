#!/bin/bash

force_override=false

while getopts "f" opt; do
  case ${opt} in
    f )
      force_override=true
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done

if [ -z "$CONFIG_FILE_PATH" ] || [ "$force_override" = true ]; then
  export config_file_path="$(cd "$(dirname "$0")" && pwd)/$0"
  echo "INFO: Old CONFIG_FILE_PATH is '$CONFIG_FILE_PATH'. Setting to: $config_file_path"
  sudo echo "export CONFIG_FILE_PATH=$config_file_path" >> /etc/bash.bashrc
  exit 0
else
  echo "INFO: CONFIG_FILE_PATH is: $CONFIG_FILE_PATH"
fi

BACKUP_DIR=/home/backup
LOG_DIR=/var/log
DOKCER_CONTAINER_DIR=/home/docker
