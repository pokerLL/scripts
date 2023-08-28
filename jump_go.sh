#!/bin/bash

# 定义跳板机列表
declare -a d=(
    "product@172.17.132.132"
)

# 提示用户可用的机器列表
echo "可用机器列表："
for i in "${!d[@]}"; do
    echo "$((i+1)). ${d[$i]}"
done

# 循环等待用户输入
while true; do
    read -p "请输入要连接的机器序号 (或输入 'q' 退出): " choice
    if [[ $choice == "q" ]]; then
        echo "已取消连接"
        exit
    fi
    if [[ ! $choice =~ ^[0-9]+$ ]]; then
        echo "无效的序号，请重新输入"
        continue
    fi
    if (( choice > ${#d[@]} || choice < 1 )); then
        echo "无效的序号，请重新输入"
        continue
    fi
    read -p "您选择的机器是 ${d[$((choice-1))]}，确认要连接此机器吗？[y/n]: " confirm
    case $confirm in
        y|Y|"")
            break;;
        *)
            echo "已取消连接"
            exit;;
    esac
done

# 连接目标机器
# ssh "${d[$((choice-1))]}"
echo "${d[$((choice-1))]}"