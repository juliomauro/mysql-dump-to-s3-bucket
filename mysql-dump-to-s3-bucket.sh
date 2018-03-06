#!/bin/sh
## Author: Julio Cesar Mauro
## Date: 03-06-2018
## Script to backup mysql database into AWS S3 BUCKET

#### BEGIN CONFIGURATION ####
# set dump directory variables
SRCDIR='/tmp/s3backups'
DESTDIR='mysqldump'
BUCKET='BUCKET-NAME'

# database access details
HOST='MYSQL-SERVER'
PORT='3306'
USER='USERNAME'
PASS='PASSWORD'
#### END CONFIGURATION ####

# make the temp directory if it doesn't exist and cd into it
mkdir -p $SRCDIR
cd $SRCDIR

# dump each database to its own sql file and upload it to s3
for DB in $(mysql -h$HOST -P$PORT -u$USER -p$PASS -BNe 'show databases' | grep -Ev 'mysql|information_schema|performance_schema')
do
	mysqldump -h$HOST -P$PORT -u$USER -p$PASS --quote-names --create-options --force $DB > $DB.sql
	tar -czPf $DB.tar.gz $DB.sql
	/usr/local/bin/aws s3 cp $SRCDIR/$DB.tar.gz s3://$BUCKET/$DESTDIR/
done

# remove all files in our source directory
cd
rm -f $SRCDIR/*
