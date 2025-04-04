#!/bin/bash


BACKUP_DIR="./backups"


mkdir -p ${BACKUP_DIR}


TIMESTAMP=$(date +"%Y%m%d_%H%M%S")


DB_USER=${DB_USER:-admin}
DB_PASSWORD=${DB_PASSWORD:-secret}
DB_NAME=${DB_NAME:-mydatabase}
DB_HOST=${DB_HOST:-db}


BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"


MYSQL_CONTAINER="mysql_db"


echo "Starting backup of database: ${DB_NAME}..."
docker exec ${MYSQL_CONTAINER} mysqldump -u ${DB_USER} -p${DB_PASSWORD} ${DB_NAME} > ${BACKUP_FILE}


if [ $? -eq 0 ]; then
    echo "Backup successful: ${BACKUP_FILE}"
else
    echo "Backup failed!"
    exit 1
fi
