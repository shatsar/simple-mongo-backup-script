#!/bin/bash

#--
# CONFIG
DBS="mashape"
DUMP_LOCATION=~/backup/mongo
LOGS_LOCATION=~/backup/logs
DIR_NAME=db-`date +%Y%m%d`
DIR_NAME_ABS=$DUMP_LOCATION/$DIR_NAME
COPY_SSH_DEST=server1:$DIR_NAME_ABS
##--

echo "Starting backup `date`"
for DB in $DBS
do
	echo "Backup: $DB"
	mongodump --db $DB --out $DIR_NAME_ABS
	tar -czf $DUMP_LOCATION/$DB-`date +%Y%m%d`.tgz --remove-files --directory $DUMP_LOCATION $DIR_NAME
	scp	$DUMP_LOCATION/$DB-`date +%Y%m%d`.tgz $COPY_SSH_DEST
done
echo "Backup Finished"
