#!/bin/bash

#--
# CONFIG
DBS="mashape"
DUMP_LOCATION=~/backup/mongo
LOGS_LOCATION=~/backup/logs
DIR_NAME=db-`date +%Y%m%d`
LOG_FILE=$DUMP_LOCATION/log-`date +%Y%m%d`
DIR_NAME_ABS=$DUMP_LOCATION/$DIR_NAME
COPY_SSH_DEST=server1:$DIR_NAME_ABS
# Uncomment and configure
#USERNAME="username"
#PASSWORD="password"
##--

AUTH=""

if [ -n "$USERNAME" ]
	then
	AUTH=" -u $USERNAME -p $PASSWORD";
fi

echo "Starting backup `date`" >> $LOG_FILE

for DB in $DBS
do
	echo "Backup: $DB" >> $LOG_FILE
	mongodump --db $DB $AUTH --out $DIR_NAME_ABS >> $LOG_FILE
	tar -czf $DUMP_LOCATION/$DB-`date +%Y%m%d`.tgz --remove-files --directory $DUMP_LOCATION $DIR_NAME >> $LOG_FILE
	scp	$DUMP_LOCATION/$DB-`date +%Y%m%d`.tgz $COPY_SSH_DEST >> $LOG_FILE
done
echo "Backup Finished" >> $LOG_FILE
