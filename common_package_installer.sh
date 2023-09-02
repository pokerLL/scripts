#!/bin/bash

# 软件包数组
packages=(
  "curl"
  "wget"
  "tmux"
  "tree"
  "git"
  "vim"
  "openssh-server"
  "rsync"
)

# 安装常用软件
install_packages() {
  sudo $1 update
  for package in "${packages[@]}"; do
    echo "正在安装软件包：$package"
    sudo $1 install -y "$package"
  done
}

if [ $# -eq 0 ] || [ $1 == "apt" ]; then
   install_packages apt
elif [ $1 == "yum" ];then
   install_packages yum
fi
