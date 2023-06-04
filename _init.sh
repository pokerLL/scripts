#!/bin/bash

source /.scripts_config

open_restart=false

while getopts "r" opt; do
  case $opt in
    r)
      open_restart=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

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

  echo "[$(now)] 目录 $directory 处理完成"
done

alias ssc="systemctl "
alias sscl="systemctl list-units "
alias jnc="journalctl "
alias jncu="journalctl -fu "

if [ "$open_restart" = true ]; then
  echo "open_restart is on "
  bash "$BASE_DIR"/back_docker_service_data.sh
  systemctl restart frpc
fi