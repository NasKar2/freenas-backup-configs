# freenas-iocage-configs_backup
Backup config files for scripts
## Set these variable before running the script
Create a file with your text editor call backupconfigs-config with the variables listed below
```
cron=""
CONFIGS_PATH="/git/freenas-iocage-configs_backup"
CONFIGS_LIST="configs.txt"
BACKUP_PATH="/mnt/v1/backup"
BACKUP_NAME="configs.tar.gz"
RESTORE_PATH="/git/temp"
```
cron set to "yes" if you want to only do backup when script executed
CONFIGS_PATH is the location where the configs.tar.gz file will be located after a backup
CONFIG_LIST is the list of all the config files
BACKUP_PATH is the location where the configs.tar.gz (config files) will be located
BACKUP_NAME is the name of the backup file
RESTORE_PATH is location where you want to restore the configs
