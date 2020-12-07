#!/bin/bash

Date=$(date +"%Y-%m-%d %H:%M:%S")
count_SystemOut=$(find  /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/Server1/SystemOut_*.log -maxdepth 1 -type f -mtime +30 -print | wc -l)
count_SystemErr=$(find  /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/Server1/SystemErr_*.log -maxdepth 1 -type f -mtime +30 -print | wc -l)
count=$((count_SystemOut+count_SystemErr))

    echo "                                                                              "  >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log
    echo " ********************* Older than 30days Server1 logs were deleted at $Date *********************"   >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log
    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log
# Older than 30days logs will be listed
    echo " Below listed logs were deleted :-" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log
    echo " Total no of logs deleted : $count" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log
    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log
    find  /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/Server1/SystemOut_*.log -maxdepth 1 -type f -mtime +30 -print  >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log 2>&1
    find  /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/Server1/SystemErr_*.log -maxdepth 1 -type f -mtime +30 -print  >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log 2>&1

# 30 days log retension policy
   find  /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/Server1/SystemOut_*.log -mtime +30 -exec rm {} \;
   find  /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/Server1/SystemErr_*.log -mtime +30 -exec rm {} \;

    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/CronjobLogs/cronjobServer1.log
~
~
~
~

