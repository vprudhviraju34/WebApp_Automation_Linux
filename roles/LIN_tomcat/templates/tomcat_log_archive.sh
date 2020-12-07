#!/bin/bash


Date=$(date +"%Y-%m-%d %H:%M:%S")

    echo "                                                                              "  >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log
    echo " ********************* Older than 30days logs were deleted at $Date *********************"   >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log
# Older than 30days logs will be listed
    echo " Below listed logs were deleted :-" >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log

     find  /appl/freeware/tomcat/logs/catalina.*.log  -maxdepth 1 -type f -mtime +30 -print  >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log 2>&1
     find  /appl/freeware/tomcat/logs/manager.*.log  -maxdepth 1 -type f -mtime +30 -print  >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log 2>&1
     find  /appl/freeware/tomcat/logs/host-manager.*.log  -maxdepth 1 -type f -mtime +30 -print  >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log 2>&1
     find  /appl/freeware/tomcat/logs/localhost.*.log  -maxdepth 1 -type f -mtime +30 -print  >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log 2>&1
     find  /appl/freeware/tomcat/logs/localhost_access_log.*.txt  -maxdepth 1 -type f -mtime +30 -print  >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log 2>&1
     find  /appl/freeware/tomcat/logs/gc-*.log.*  -maxdepth 1 -type f -mtime +30 -print  >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log 2>&1
# 30 days log retension policy
     find  /appl/freeware/tomcat/logs/catalina.*.log -mtime +30 -exec rm {} \;
     find  /appl/freeware/tomcat/logs/manager.*.log -mtime +30 -exec rm {} \;
     find  /appl/freeware/tomcat/logs/host-manager.*.log -mtime +30 -exec rm {} \;
     find  /appl/freeware/tomcat/logs/localhost.*.log -mtime +30 -exec rm {} \;
     find  /appl/freeware/tomcat/logs/localhost_access_log.*.txt -mtime +30 -exec rm {} \;
     find  /appl/freeware/tomcat/logs/gc-*.log.* -mtime +30 -exec rm {} \;


    echo "                                                                              " >> /appl/freeware/tomcat/logs/CronjobLogs/cronjob.log

