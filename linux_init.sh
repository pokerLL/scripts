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
  sudo apt update
  for package in "${packages[@]}"; do
    echo "正在安装软件包：$package"
    sudo apt install -y "$package"
  done
}

# 安装conda
install_miniconda(){
   set -e
   if [ -f ./miniconda.sh ];then
       cp ./miniconda.sh ~
   else
       wget "https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-$(uname -m).sh" -O ~/miniconda.sh
   fi
   exit
   bash ~/miniconda.sh -b -p $HOME/miniconda
   ~/miniconda/bin/conda init
   echo 'Successfully installed miniconda...'
   echo -n 'Conda version: '
   ~/miniconda/bin/conda --version
   echo -e '\n'
   exec bash
}

show_menu() {
  echo "===== 软件包安装菜单 ====="
  echo "1. 安装常用软件包"
  echo "2. 安装Miniconda"
  echo "3. 退出"
  echo "========================"

  read -p "请选择操作编号: " choice

  case $choice in
    1)
      install_packages
      ;;
    2)
      install_miniconda
      ;;
    3)
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
