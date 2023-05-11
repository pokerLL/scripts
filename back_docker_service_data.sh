#!/bin/bash
BASE_DIR="$(readlink -f $(dirname "$0"))"
SCRIPT_NAME="$(basename "$0")"
DOCKER_HOME=/home/docker

now() {
    date +"%Y-%m-%d %H:%M:%S"
}
echo "[INFO] CALL $BASE_DIR/$SCRIPT_NAME $* at $(now)"

echo "=========================================================="
echo "[$(now)] Start to backup docker service data..."

cd $DOCKER_HOME

for dir in */; do
  if [ ! -f "$dir/docker-compose.yml" ]; then
    echo "[$(now)] No docker-compose.yml file found in directory $dir, skipping..."
    continue
  fi

  if [ -f "$dir/.skip" ]; then
    echo "[$(now)] .skip file found in directory $dir, skipping..."
    continue
  fi

  cd "$dir"

  docker-compose down
  cd ..
done

bash "$BASE_DIR"/back_file_or_dir.sh /mnt/DATA/docker $DOCKER_HOME
bash "$BASE_DIR"/auto_start_all_docker_service.sh

echo "[$(now)] Complete to backup docker service data."
echo "=========================================================="
