#!/bin/bash

cd /home/docker

for dir in */; do
  # 判断是否存在docker-compose.yml文件
  if [ ! -f "$dir/docker-compose.yml" ]; then
    echo "No docker-compose.yml file found in directory $dir, skipping..."
    continue
  fi

  if [ -f "$dir/.skip" ]; then
    echo ".skip file found in directory $dir, skipping..."
    continue
  fi

  continue

  cd "$dir"

  # 获取docker-compose.yml文件中定义的所有服务名称
  services=$(docker-compose config --services)

  for service in $services; do
    if docker-compose ps | grep "$service" | grep -q "Up"; then
      echo "Service $service is already running, skipping..."
    else
      docker-compose up -d "$service"
    fi
  done

  cd ..
done
