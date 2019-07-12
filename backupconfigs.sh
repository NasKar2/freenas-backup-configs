#!/bin/sh
#backup and restore config files

# add file names to a file specified in CONFIGS_LIST

# Set these variable before running the script
#
cron=""
CONFIGS_PATH="/git/temp"
CONFIGS_LIST="configs.txt"
BACKUP_PATH="/mnt/v1/backup"
BACKUP_NAME="configs.tar.gz"
#
#

#tar -cvf configs.tar -T configs.txt

if [ "$cron" != "yes" ]; then
 read -p "Enter '(B)ackup' to backup Config files or '(R)estore' to restore Config files: " choice
fi
echo

if [ "${cron}" == "yes" ]; then
    choice="B"
fi

echo
if [ ${choice} == "B" ] || [ ${choice} == "b" ]; then
    if [ ! -d "${BACKUP_PATH}" ]; then
      mkdir -p ${{BACKUP_PATH}
      echo "mkdir -p ${${BACKUP_PATH}"
    fi
  # to backup
  #tar --exclude=./*.db-* -zcvf /mnt/v1/apps/sonarrbackup.tar.gz ./
  cd /${CONFIGS_PATH}
  echo
  echo "/${CONFIGS_PATH}"
  tar -cvf ${BACKUP_NAME} -T ${CONFIGS_LIST}
# tar --exclude='./nzbdrone.db-*' --exclude='nzbdrone.pid' -zcpf ${BACKUP_PATH}/${BACKUP_NAME} ./*

  echo
#  echo "tar --exclude='./nzbdrone.db-*' --exclude='nzbdrone.pid' -zcpf ${BACKUP_PATH}/${BACKUP_NAME} ./*"
  echo "tar -cvf ${BACKUP_NAME} -T ${CONFIGS_LIST}"
  echo "Backup complete file located at ${CONFIGS_PATH}/${BACKUP_NAME}"
  echo
elif [ $choice == "R" ] || [ $choice == "r" ]; then
    if [ ! -d "${CONFIGS_PATH}" ]; then
      mkdir -p ${CONFIGS_PATH}
      echo
      echo "mkdir -p ${CONFIGS_PATH}"
      echo
#     chowm -R media:media ${CONFIGS_PATH}                                                                      
#     echo "chown -R media:media ${CONFIGS_PATH}"
    fi
echo "before tar"
  tar zvxpf /${BACKUP_PATH}/${BACKUP_NAME} -C /${CONFIGS_PATH}
  echo
  echo "tar zvxpf ${BACKUP_PATH}/${BACKUP_NAME} -C ${CONFIGS_PATH}"
  echo
  echo "Restore completed at ${CONFIGS_PATH}"
  echo
else
  echo
  echo "Must enter '(B)ackup' to backup Config files or '(R)estore' to restore Config files: "
  echo
fi
