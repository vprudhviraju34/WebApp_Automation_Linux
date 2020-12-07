#!/bin/bash

# 30 days log retension policy 
 find  /appl/RH/jboss/standalone/log/server.log.* -mtime +30 -exec rm {} \;



Date=$(date +"%Y-%m-%d %H:%M:%S")

    echo "                                                                              "  >> /appl/RH/jboss/standalone/log/CronjobLogs/cronjob.log
    echo " ********************* Older than 30days logs were deleted at $Date *********************"   >> /appl/RH/jboss/standalone/log/CronjobLogs/cronjob.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/CronjobLogs/cronjob.log
# Older than 30days logs will be listed
    echo " Below listed logs were deleted :-" >> /appl/RH/jboss/standalone/log/CronjobLogs/cronjob.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/CronjobLogs/cronjob.log

     find  /appl/RH/jboss/standalone/log/server.log.*  -maxdepth 1 -type f -mtime +30 -print >> /appl/RH/jboss/standalone/log/CronjobLogs/cronjob.log 2>&1
# 30 days log retension policy
     find  /appl/RH/jboss/standalone/log/server.log.* -mtime +30 -exec rm {} \;


    echo "                                                                              " >> /appl/RH/jboss/standalone/log/CronjobLogs/cronjob.log

