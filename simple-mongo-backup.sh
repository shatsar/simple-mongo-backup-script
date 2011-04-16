#!/bin/bash
# CONFIGURATION
DBS=”db1 db2”
DUMP_LOCATION=~/backup
DIR_NAME=db-`date +%Y%m%d`
DIR_NAME_ABS=$DUMP_LOCATION/$DIR_NAME
COPY_SSH_DEST=server1:$DIR_NAME_ABS
##—

echo “Starting backup `date`”
for DB in $DBS
do
	echo “Backup: $DB”
	mongodump —db $DB —out $DIR_NAME_ABS
done

scp -r $DIR_NAME_ABS $COPY_SSH_DEST
echo “Backup Finished `date`”
