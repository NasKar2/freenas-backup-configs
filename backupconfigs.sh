#!/bin/sh
#backup and restore config files

# Check for root privileges
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run with root privileges"
   exit 1
fi

# add file names to a file specified in CONFIGS_LIST

# Initallize variables
#
CONFIGS_PATH="/git/freenas-iocage-configs_backup"
CONFIGS_LIST="configs.txt"
BACKUP_PATH="/mnt/v1/backup"
BACKUP_NAME="configs.tar.gz"
RESTORE_PATH="/git/temp"
#
#

# Check for root privileges
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run with root privileges"
   exit 1
fi

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
. $SCRIPTPATH/backupconfigs-config
#RELEASE=$(freebsd-version | cut -d - -f -1)"-RELEASE"

# Check for backupconfigs-config and set configuration
if ! [ -e $SCRIPTPATH/backupconfigs-config ]; then
  echo "$SCRIPTPATH/backupconfigs-config must exist."
  exit 1
fi
# Check that necessary variables were set by backupconfigs-config
if [ -z $CONFIGS_PATH ]; then
  echo 'Configuration error: CONFIGS_PATH must be set'
  exit 1
fi
if [ -z $CONFIGS_LIST ]; then
  echo 'Configuration error: CONFIGS_LIST must be set'
  exit 1
fi
if [ -z $BACKUP_PATH ]; then
  echo 'Configuration error: BACKUP_PATH must be set'
  exit 1
fi
if [ -z $BACKUP_NAME ]; then
  echo 'Configuration error: BACKUP_NAME must be set'
  exit 1
fi

#tar -cvf configs.tar -T configs.txt

#
# Ask to Backup or restore, if run interactively
#
if ! [ -t 1 ] ; then
  # Not run interactively
  choice="B"
else
 read -p "Enter '(B)ackup' to backup Nextcloud or '(R)estore' to restore Nextcloud: " choice
fi

echo
echo $choice

echo
if [ "${choice}" = "B" ] || [ "${choice}" = "b" ]; then
echo $choice
    if [ ! -d "${BACKUP_PATH}" ]; then
      mkdir -p ${BACKUP_PATH}
      echo "mkdir -p ${BACKUP_PATH}"
    fi
  # to backup
  #tar --exclude=./*.db-* -zcvf /mnt/v1/apps/sonarrbackup.tar.gz ./
  cd ${CONFIG_PATH}
  echo
  echo "${CONFIG_PATH}"
  tar cfP ${BACKUP_PATH}/${BACKUP_NAME} -T ${CONFIGS_PATH}/${CONFIGS_LIST}
echo ${CONFIGS_PATH}/${CONFIGS_LIST}
#chmod 660 ${BACKUP_PATH}/${BACKUP_NAME}
# tar --exclude='./nzbdrone.db-*' --exclude='nzbdrone.pid' -zcpf ${BACKUP_PATH}/${BACKUP_NAME} ./*

  echo
#  echo "tar --exclude='./nzbdrone.db-*' --exclude='nzbdrone.pid' -zcpf ${BACKUP_PATH}/${BACKUP_NAME} ./*"
  echo "tar cvfP ${BACKUP_PATH}/${BACKUP_NAME} -T ${CONFIGS_PATH}/${CONFIGS_LIST}"
  echo "Backup complete file located at ${BACKUP_PATH}/${BACKUP_NAME}"
  echo
elif [ "$choice" = "R" ] || [ "$choice" = "r" ]; then
    if [ ! -d "${BACKUP_PATH}" ]; then
      mkdir -p ${BACKUP_PATH}
      echo
      echo "mkdir -p ${BACKUP_PATH}"
      echo
#     chowm -R media:media ${BACKUP_PATH}                                                                      
#     echo "chown -R media:media ${BACKUP_PATH}"
    fi
echo "before tar"
  tar zvxpf ${BACKUP_PATH}/${BACKUP_NAME} -C ${RESTORE_PATH}
  echo
  echo "tar zvxpf ${BACKUP_PATH}/${BACKUP_NAME} -C ${RESTORE_PATH}"
  echo
  echo "Restore completed at ${RESTORE_PATH}"
  echo
else
  echo
  echo "Must enter '(B)ackup' to backup Config files or '(R)estore' to restore Config files: "
  echo
fi
