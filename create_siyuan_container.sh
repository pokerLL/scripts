#!/bin/bash

BASE_DIR="$(readlink -f $(dirname "$0"))"
DOCKER_HOME=/home/docker

now() {
    date +"%Y-%m-%d %H:%M:%S"
}
echo "[INFO] CALL $BASE_DIR/$0 $* at $(now)"

echo "================START==================="

if [ $# != 2 ]; then
	echo "使用示例: $0 [容器名] [端口号]"
	echo "例如: $0 siyuan 8080"
	exit 0
fi

container_name=$1
mount_dir=$DOCKER_HOME/${container_name}
host_port=$2

echo "容器名: ${container_name} --> 挂载目录: ${mount_dir} --> 映射端口: ${host_port}"

if [ -d "$mount_dir" ]; then
	read -p "目录 ${mount_dir} 已存在，是否删除已有数据并重新创建？[y/n]" choice
	if [ "$choice" == "y" ]; then
		sudo rm -rf "$mount_dir"
		echo "已删除目录 ${mount_dir}"
	else
		echo "已保留目录 ${mount_dir}"
	fi
fi

sudo mkdir -p "$mount_dir"
sudo chown -R 1000:1000 "$mount_dir"

docker stop "$container_name" && docker rm -f "$container_name"

docker run -d --restart=always --name "$container_name" -v "$mount_dir":"$mount_dir" -p "$host_port":6806 -u 1000:1000 b3log/siyuan -workspace "$mount_dir"

if [ $(docker ps -aqf "name=${container_name}") ]; then
	echo "容器 ${container_name} 创建成功"
fi

echo "================DONE==================="
