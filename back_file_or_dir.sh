#!/bin/bash

if [ -z "$CONFIG_FILE_PATH" ] || [ ! -f "$CONFIG_FILE_PATH" ]; then
  echo "ERROR: CONFIG_FILE_PATH is not set or does not exist."
  exit 1
fi
source "$CONFIG_FILE_PATH"

start_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Starting backup at $start_time"

if [ $# -lt 2 ]; then # 检查参数数量是否少于2个
  echo "Usage: $0 backup_folder_name source_path [backup_file_name]"
  exit 1
fi

if [ ! -e $2 ]; then # 检查第二个参数是否为一个存在的文件或目录
  echo "Error: $2 is not a valid file or directory"
  exit 1
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
  sudo tar -czf $backup_file $2
else # 如果是文件，则进行文件备份
  sudo cp $2 $backup_file
fi


end_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Backup completed at $end_time"

start_timestamp=$(date -d "$start_time" +%s)
end_timestamp=$(date -d "$end_time" +%s)
elapsed_time=$((end_timestamp - start_timestamp))
backup_size=$(sudo du -sh $backup_file | awk '{print $1}')
current_user=$(whoami)

# 将备份信息写入日志文件
log_file="$LOG_DIR/backup_$1.log"
log_str="[$end_time] Backup completed successfully. Backup file is located at $backup_file. Backup file size: $backup_size. Elapsed time: ${elapsed_time}s. Executed by user: $current_user." 
echo "$log_str"
sudo echo "$log_str" >> $log_file
