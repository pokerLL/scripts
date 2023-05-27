#!/bin/bash

source /.scripts_config

SCRIPT_NAME="$(basename "$0")"

echo "[INFO] CALL $BASE_DIR/$SCRIPT_NAME $* at $(now)"
cd $DOCKER_DIR

if [ -d $DOCKER_DIR/_init ]; then
    # 执行_init目录下的所有.sh文件
  find "$DOCKER_DIR/_init" -type f -name "*.sh" -exec sudo bash {} \;
fi

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

  # 如果目录下有初始化脚本则执行
  if [ -f "$dir/_init.sh" ]; then
    sudo bash $dir/_init.sh
  fi
  
  cd "$dir"

  # # 获取docker-compose.yml文件中定义的所有服务名称
  # services=$(docker-compose config --services)

  # for service in $services; do
  #   if docker-compose ps | grep "$service" | grep -q "Up"; then
  #     echo "Service $service is already running, skipping..."
  #   else
  #     docker-compose up -d "$service"
  #   fi
  # done

  docker-compose up -d

  cd ..
done
