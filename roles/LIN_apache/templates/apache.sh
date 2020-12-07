#!/bin/bash

#User to start Apache services
SUDO_APACHE_USER="webadm"


#Commands to start/stop Apache service

START_SERVER="/appl/freeware/apache/bin/apachectl start"
STOP_SERVER="/appl/freeware/apache/bin/apachectl stop"
RESTART_SERVER="/appl/freeware/apache/bin/apachectl graceful"
Date=$(date +"%Y-%m-%d %H:%M:%S")

start() {

    chmod -R 755 /appl/freeware/apache
    chown -R webadm:webgrp /appl/freeware/apache

    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/start.log
    echo " ********************* Apache WebServer started at $Date *********************" >> /appl/freeware/apache/logs/AutoStartupLogs/start.log
    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/start.log
    echo "Apache HTTPD Process :-" >> /appl/freeware/apache/logs/AutoStartupLogs/start.log
    sudo -u ${SUDO_APACHE_USER} -i ${START_SERVER} >> /appl/freeware/apache/logs/AutoStartupLogs/start.log
    process=$(ps -ef|grep -i httpd)
    echo $process >> /appl/freeware/apache/logs/AutoStartupLogs/start.log

    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/start.log
    echo " *******************************************************************************************" >> /appl/freeware/apache/logs/AutoStartupLogs/start.log

    chmod -R 755 /appl/freeware/apache
    chown -R webadm:webgrp /appl/freeware/apache

}

stop() {

    chmod -R 755 /appl/freeware/apache
    chown -R webadm:webgrp /appl/freeware/apache

    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo " ********************* Apache WebServer stopped at $Date *********************" >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo " Below is the Apache HTTPD process before stopping apache"  >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    process_start=$(ps -ef|grep -i httpd)
    echo $process_start >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log

    sudo -u ${SUDO_APACHE_USER} -i ${STOP_SERVER} >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo " Apache process stopped successfully .."  >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    #process_stop=$(ps -ef|grep -i httpd)
    #echo $process_stop >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log
    echo " *******************************************************************************************" >> /appl/freeware/apache/logs/AutoStartupLogs/stop.log

    chmod -R 755 /appl/freeware/apache
    chown -R webadm:webgrp /appl/freeware/apache
}

restart() {

    chmod -R 755 /appl/freeware/apache
    chown -R webadm:webgrp /appl/freeware/apache

    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log
    echo " ********************* Apache WebServer restarted at $Date *********************" >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log
    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log

    echo "Apache HTTPD Process :-" >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log
    sudo -u ${SUDO_APACHE_USER} -i ${RESTART_SERVER} >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log
    process=$(ps -ef|grep -i httpd)
    echo $process >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log

    echo "                                                                              " >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log
    echo " *******************************************************************************************" >> /appl/freeware/apache/logs/AutoStartupLogs/restart.log

    chmod -R 755 /appl/freeware/apache
    chown -R webadm:webgrp /appl/freeware/apache

}

case $1 in
    start|stop|restart) "$1" ;;
esac

