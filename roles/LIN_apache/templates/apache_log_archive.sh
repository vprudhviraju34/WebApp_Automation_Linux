#!/bin/bash

# Log Rotation Script


filelist1="/tmp/filelist1"
filelist2="/tmp/filelist2"
filelist3="/tmp/filelist3"
dir=/appl/freeware/apache/logs
dir1=/appl/freeware/apache/scripts/logs


# zipping Logs older than 3 Days

zip()
{

find $dir -maxdepth 1 -mtime +3 -type f \( -name "access.log.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]" -o -name "error.log.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]" \) >> $filelist1


for i in `cat $filelist1`
        do
                gzip "$i"
                echo " `basename $i` compression completed.. " >>  /appl/freeware/apache/scripts/logs/logRotation.log
        done

}

# Remove Zipped files older than 15 days

remove()
{

find $dir -maxdepth 1 -mtime +15 -type f \( -name "access.log.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].gz" -o -name "error.log.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].gz" \) >> $filelist2

for i in `cat $filelist2`
do
rm "$i"
echo " `basename $i` Removal completed.. " >>  /appl/freeware/apache/scripts/logs/logRotation.log
done
}

# logrotation for script logs

logrotate()
{

find $dir1 -maxdepth 1 -type f -name "logRotation.log" >> $filelist3

cd /appl/freeware/apache/scripts/logs

for i in `cat $filelist3`

        do
                cp $i "$i"_`date +%d%m%Y`
                > $i
         #       echo  "`basename  $i` LogRotate for script log completed.."
        done
}

main ()
{
        zip
        remove
        logrotate
}

main

rm -f $filelist1
rm -f $filelist2
rm -f $filelist3

# Remove script logs older than 7 days
find  /appl/freeware/apache/scripts/logs/logRotation.log* -mtime +7 -exec rm {} \;
chmod -R 755 /appl/freeware/apache/scripts/logs
chown -R webadm:webgrp /appl/freeware/apache/scripts/logs

