# freenas-backup-configs
Backup config files for scripts
## Set these variable before running the script
Create a file with your text editor call backupconfigs-config with the variables listed below
To automate backup, create a cron job pointing to the backup script. The prompts wll be bypassed in any non-interactive operation like a cron task in the FreeNAS GUI.
```
CONFIGS_PATH="/git/freenas-iocage-configs_backup"
CONFIGS_LIST="configs.txt"
BACKUP_PATH="/mnt/v1/backup"
BACKUP_NAME="configs.tar.gz"
RESTORE_PATH="/"
```
CONFIGS_PATH is the location where the configs.tar.gz file will be located after a backup
CONFIG_LIST is the list of all the config files
BACKUP_PATH is the location where the configs.tar.gz (config files) will be located
BACKUP_NAME is the name of the backup file
RESTORE_PATH is location where you want to restore the configs. If "/" it will restore to the original locations

## You can create the configs.txt file automatically with this command
```
find /mnt/v1/git -name '*-config' > configs.txt
```

where /mnt/v1/git is the root of your git directories
