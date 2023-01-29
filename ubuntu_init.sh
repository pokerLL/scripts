#!/bin/bash

function ubuntu_init()
{
apt update
apt install sudo -y
apt install vim -y
apt install tmux -y
apt install git -y
apt install curl -y
apt install tree -y
apt install wget -y
apt install openssh-server -y
apt install openssh-client -y
apt install curl -y
}

function install_docker(){
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo rm -f get-docker.sh
}

function menu()
{
echo "###########################################################"
echo "#              Please enter your choise:                  #"
echo "#              (0) 执行全部                               #"
echo "#              (1) 安装ssh curl tmux vim等常用软件(默认)  #"
echo "#              (2) 安装docker                             #"
echo "#              (q) 退出			                #"
echo "###########################################################"

read cho

sudo apt update

case $cho in
	0)
	ubuntu_init
	install_docker
	;;
	1)
	ubuntu_init
	;;
	2)
	install_docker
	;;
	q)
	exit
	;;
	*)
	ubuntu_init
	;;
esac
}

menu
