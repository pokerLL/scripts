#!/bin/bash

source /.scripts_config

# 配置目录数组
directories=(
  "/home/docker"
)

# 遍历目录进行操作
for directory in "${directories[@]}"; do
  if [ -d "$directory/_init" ]; then
    find "$directory/_init" -name "*.sh" -exec bash {} \;
  fi

  if [ -f "$directory/_init.sh" ]; then
    bash "$directory/_init.sh"
  fi
done

source /scripts-collection/proxy_tool.sh


alias d='docker'
alias dc='docker-compose'
alias dcr='docker-compose down && docker-compose up -d'

export PATH=$PATH:/scripts-collection



