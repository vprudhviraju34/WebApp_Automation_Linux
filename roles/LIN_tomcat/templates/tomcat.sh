#!/bin/bash

#User to start Tomcat services
SUDO_TOMCAT_USER="tomcat"


#Commands to start/stop Tomcat services

START_SERVER="/appl/freeware/tomcat/bin/startup.sh"
STOP_SERVER="/appl/freeware/tomcat/bin/shutdown.sh"
Date=$(date +"%Y-%m-%d %H:%M:%S")

start() {

    chmod -R 755 /appl/freeware/tomcat
    chown -R tomcat:tomgrp /appl/freeware/tomcat

    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log
    echo " ********************* Apache tomcat started at $Date *********************" >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log
    echo "Apache tomcat Process :-" >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log
    sudo -u ${SUDO_TOMCAT_USER} -i ${START_SERVER} >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log
    process=$(ps -ef|grep -i java|grep -i tomcat)
    echo $process >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log

    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log
    echo " *******************************************************************************************" >> /appl/freeware/tomcat/logs/AutoStartupLogs/start.log

    chmod -R 755 /appl/freeware/tomcat
    chown -R tomcat:tomgrp /appl/freeware/tomcat

}


stop() {

    chmod -R 755 /appl/freeware/tomcat
    chown -R tomcat:tomgrp /appl/freeware/tomcat

    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo " ********************* Apache tomcat stopped at $Date *********************" >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo " Below is the tomcat process before stopping "  >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    process_start=$(ps -ef|grep -i java|grep -i tomcat)
    echo $process_start >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log

    sudo -u ${SUDO_TOMCAT_USER} -i ${STOP_SERVER} >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo " Apache Tomcat process stopped successfully .."  >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    #process_stop=$(ps -ef|grep -i httpd)
    #echo $process_stop >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log
    echo " *******************************************************************************************" >> /appl/freeware/tomcat/logs/AutoStartupLogs/stop.log

    chmod -R 755 /appl/freeware/tomcat
    chown -R tomcat:tomgrp /appl/freeware/tomcat
}

restart() {

    chmod -R 755 /appl/freeware/tomcat
    chown -R tomcat:tomgrp /appl/freeware/tomcat

    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log
    echo " ********************* Apache Tomcat restarted at $Date *********************" >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log

    echo "Apache tomcat Process :-" >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log
    sudo -u ${SUDO_TOMCAT_USER} -i ${STOP_SERVER} >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log
    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log
    sudo -u ${SUDO_TOMCAT_USER} -i ${START_SERVER} >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log
    process=$(ps -ef|grep -i java|grep -i tomcat)
    echo $process >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log

    echo "                                                                              " >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log
    echo " *******************************************************************************************" >> /appl/freeware/tomcat/logs/AutoStartupLogs/restart.log

    chmod -R 755 /appl/freeware/tomcat
    chown -R tomcat:tomgrp /appl/freeware/tomcat

}

case $1 in
    start|stop|restart) "$1" ;;
esac


