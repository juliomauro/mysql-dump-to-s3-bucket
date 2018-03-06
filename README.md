# Backup mysql database into AWS S3 BUCKET
Backup mysql database into AWS S3 BUCKET

This is a script for backup MySQL database in an Amazon S3 Bucket. 

The mysql-dump-to-s3-bucket.sh script performs the following operations each time you run it:

Dumps each database into its own .sql file.
Tars all of the .sql files into a directory on the server.
Uploads the tarred file to S3 and deletes the tarred file from the local server.

# Setup

1. Install aws cli. See https://docs.aws.amazon.com/cli/latest/userguide/installing.html for instructions.
1. Configure aws cli to work with your AWS account: `aws configure`. 
You can access or generate your AWS security credentials here.
1. Create an S3 bucket: `aws s3 mb s3://my-database-backups`.
1. Put the mysql-dump-to-s3-bucket.sh backup script somewhere on your server (ie - /opt/scripts).
1. Give the mysql-dump-to-s3-bucket.sh script 755 permissions: `chmod 755 /opt/scripts/mysql-dump-to-s3-bucket.sh`.
1. Edit the variables near the top of backup script to match your bucket, directory, and MySQL authentication.

# Example Cron Usage

1. Edit your crontab: `crontab -e`.
1. Add the following line to your crontab. This will execute the backup script at 2am every day and will email you the results of the run.

 `0 2 * * * /opt/scripts/mysql-dump-to-s3-bucket.sh |mail -s "Backup Mysql to S3 Output" -c email@exmaple.com`
