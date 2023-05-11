#!/bin/bash
BASE_DIR="$(readlink -f $(dirname "$0"))"
DOCKER_HOME=/home/docker

now() {
    date +"%Y-%m-%d %H:%M:%S"
}
echo "[INFO] CALL $BASE_DIR/$0 $* at $(now)"

cd $DOCKER_HOME

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