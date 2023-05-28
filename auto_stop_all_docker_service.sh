#!/bin/bash

source /.scripts_config

SCRIPT_NAME="$(basename "$0")"

echo "[INFO] CALL $BASE_DIR/$SCRIPT_NAME $* at $(now)"
cd $DOCKER_DIR

for dir in */; do

  # 判断是否存在docker-compose.yml文件或.skip文件,如果存在则说明这个目录跳过即可
  if [ ! -f "$dir/docker-compose.yml" ]; then
    echo "No docker-compose.yml file found in directory $dir, skipping..."
    continue
  fi

  if [ -f "$dir/.skip" ]; then
    echo ".skip file found in directory $dir, skipping..."
    continue
  fi
  
  docker-compose -f "$dir"/docker-compose.yml down

done
