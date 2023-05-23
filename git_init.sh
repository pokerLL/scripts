#!/bin/bash

# 检查参数
if [ $# -ne 2 ]; then
	echo "Usage: $0 <username> <email>"
	exit 1
fi

# 获取参数
username=$1
email=$2

# 检查email是否合法
if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
	echo "Error: Invalid email format"
	exit 1
fi

# 初始化git
git config --global user.name "$username"
git config --global user.email "$email"
git config --global core.editor "vim"
