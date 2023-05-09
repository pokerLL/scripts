#!/bin/bash

if [ $# -lt 1 ]; then # 检查参数数量是否少于1个
  echo "Usage: $0 container_name [container_path]"
  exit 1
fi

container_name=$1

if [ -z "$2" ]; then 
  container_path="/home/docker/$container_name"
else
  container_path=$2
fi

source_folder_path="$container_path/data"

if [ ! -d "$source_folder_path" ]; then # 检查源文件夹是否存在
  echo "Error: $source_folder_path is not a valid folder"
  exit 1
fi

docker stop $container_name

sudo bash "$(readlink -f $(dirname "$0"))/back_file_or_dir.sh" "$container_name" "$source_folder_path"

docker start $container_name