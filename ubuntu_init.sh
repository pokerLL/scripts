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
)

# 安装常用软件
install_packages() {
  for package in "${packages[@]}"; do
    echo "正在安装软件包：$package"
    sudo apt install -y "$package"
  done
}

show_menu() {
  echo "===== 软件包安装菜单 ====="
  echo "1. 安装软件包"
  echo "2. 退出"
  echo "========================"

  read -p "请选择操作编号: " choice

  case $choice in
    1)
      install_packages
      echo "软件包安装完成"
      ;;
    2)
      echo "退出菜单"
      exit
      ;;
    *)
      echo "无效的选择"
      ;;
  esac
}

while true; do
  show_menu
done
