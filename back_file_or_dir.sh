#!/bin/bash

if [ $# -lt 2 ]; then # 检查参数数量是否少于2个
  echo "Usage: $0 backup_folder_name source_path [backup_file_name]"
  exit 1
fi

if [ ! -e $2 ]; then # 检查第二个参数是否为一个存在的文件或目录
  echo "Error: $2 is not a valid file or directory"
  exit 1
fi

if [ -z "$BACKUP_DIR" ]; then # 检查环境变量是否存在，如果不存在则设置默认值
  BACKUP_DIR="/home/backup"
fi

backup_dir=$BACKUP_DIR/$1
mkdir -p $backup_dir

# 如果没有传入备份文件名，则使用当前时间作为文件名
if [ -z "$3" ]; then
  if [ -d $2 ]; then # 如果是目录，则使用tar进行压缩
    backup_file="$backup_dir/$(date +%Y%m%d%H%M).$1.tar.gz"
  else # 如果是文件，则不使用tar进行压缩
    backup_file="$backup_dir/$(date +%Y%m%d%H%M).$(basename $2)"
  fi
else
  backup_file="$backup_dir/$3"
fi

if [ -d $2 ]; then # 如果是目录，则进行目录备份
  tar -czf $backup_file $2
else # 如果是文件，则进行文件备份
  cp $2 $backup_file
fi

echo "Backup completed successfully. Backup file is located at $backup_file"
