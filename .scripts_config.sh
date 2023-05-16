LOG_DIR=/var/log/back
BASE_DIR=/home/lei/scripts-collection
DOCKER_DIR=/home/docker
BACKUP_DIR=/mnt/BACKUP

mkdir -p $DOCKER_DIR $BACKUP_DIR $LOG_DIR

if [ ! -d $BASE_DIR ]; then
     echo "Error: $BASE_DIR is not a valid directory"
fi

now() {
    date +"%Y-%m-%d %H:%M:%S"
}