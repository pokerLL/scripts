#!/bin/bash

source /.scripts_config

SCRIPT_NAME="$(basename "$0")"

echo "[INFO] CALL $BASE_DIR/$SCRIPT_NAME $* at $(now)"

echo "=========================================================="
echo "[$(now)] Start to backup docker service data..."

bash "$BASE_DIR"/auto_stop_all_docker_service.sh 
bash "$BASE_DIR"/back_file_or_dir.sh "$BACKUP_DIR"/docker "$DOCKER_DIR"
bash "$BASE_DIR"/auto_start_all_docker_service.sh

echo "[$(now)] Complete to backup docker service data."
echo "=========================================================="
