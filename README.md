Simple Mongo Backup Script
==========================

This basic script backups data (via mongdump) of a list of databases
(provided using the $DB variable) in a folder defined by a $DUMP\_LOCATION with
the current date in the path (in format db-yyyyMMdd).

At the end of the process it launches a copy via ssh

It could be a starting point for advanced scripts.. so, have a nice fork! :)
