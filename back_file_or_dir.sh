#!/bin/bash
BASE_DIR="$(readlink -f $(dirname "$0"))"
SCRIPT_NAME="$(basename "$0")"
BACK_DIR=/home/back
LOG_DIR=/var/log/back

now() {
    date +"%Y-%m-%d %H:%M:%S"
}
echo "[INFO] CALL $BASE_DIR/$SCRIPT_NAME $* at $(now)"

start_time=$(now)
echo "[$(now)] Starting backup at $start_time"

if [ $# -lt 2 ]; then 
  echo "Usage: $0 back_folder_path source_path [backup_file_name]"
  exit 1
fi

# 检查要备份的文件或目录是否存在
if [ ! -e $2 ]; then
  echo "Error: $2 is not a valid file or directory"
  exit 1
fi

# 如果传入的是目录名是绝对路径，则直接使用该目录名作为备份目录
if [ "$(echo "$1" | cut -c1 | grep '/')" ]; then
    backup_dir=$1
else
    backup_dir=$BACK_DIR/$1
fi
mkdir -p $backup_dir

# 如果没有传入备份文件名，则使用当前时间作为文件名
if [ -z "$3" ]; then
  if [ -d $2 ]; then 
    backup_file="$backup_dir/$(date +%Y%m%d%H%M).$(basename $backup_dir).tar.gz"
  else 
    backup_file="$backup_dir/$(date +%Y%m%d%H%M).$(basename $2)"
  fi
else
  backup_file="$backup_dir/$3"
fi

if [ -d $2 ]; then
  sudo tar -czf $backup_file $2
else
  sudo cp $2 $backup_file
fi


end_time=$(now)
echo "[$(now)] Backup completed at $end_time"

start_timestamp=$(date -d "$start_time" +%s)
end_timestamp=$(date -d "$end_time" +%s)
elapsed_time=$((end_timestamp - start_timestamp))
backup_size=$(sudo du -sh $backup_file | awk '{print $1}')
current_user=$(whoami)

# 将备份信息写入日志文件
log_file="$LOG_DIR/backup_$(basename $backup_dir).log"
log_str="[INFO] Backup completed successfully. Backup file is located at $backup_file. Backup file size: $backup_size. Elapsed time: ${elapsed_time}s. Executed by user: $current_user."
echo "$log_str"
echo "[INFO] Log file is at $log_file"
sudo echo "$log_str" >> $log_file
