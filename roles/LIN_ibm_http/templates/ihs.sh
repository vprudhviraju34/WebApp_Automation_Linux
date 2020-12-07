#!/bin/bash

#User to start IHS services
SUDO_IHS_USER="webadm"


#Commands to start/stop IHS servers

START_SERVER="/appl/IBM/HTTPServer/bin/apachectl start"
STOP_SERVER="/appl/IBM/HTTPServer/bin/apachectl stop"
RESTART_SERVER="/appl/IBM/HTTPServer/bin/apachectl graceful"
Date=$(date +"%Y-%m-%d %H:%M:%S")

start() {

    chmod -R 755 /appl/IBM/HTTPServer
    chown -R webadm:webgrp /appl/IBM/HTTPServer

    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log
    echo " ********************* IBM HTTPServer started at $Date *********************" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log
    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log
    echo "IBM HTTPServer Process :-" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log
    sudo -u ${SUDO_IHS_USER} -i ${START_SERVER} >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log
    process=$(ps -ef|grep -i httpd)
    echo $process >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log

    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log
    echo " *******************************************************************************************" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/start.log

    chmod -R 755 /appl/IBM/HTTPServer
    chown -R webadm:webgrp /appl/IBM/HTTPServer

}

stop() {

    chmod -R 755 /appl/IBM/HTTPServer
    chown -R webadm:webgrp /appl/IBM/HTTPServer

    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo " ********************* IBM HTTPServer stopped at $Date *********************" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo " Below is the IBM HTTPServer process before stopping "  >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    process_start=$(ps -ef|grep -i httpd)
    echo $process_start >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log

    sudo -u ${SUDO_IHS_USER} -i ${STOP_SERVER} >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo " IBM HTTPServer stopped successfully .."  >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    #process_stop=$(ps -ef|grep -i httpd)
    #echo $process_stop >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log
    echo " *******************************************************************************************" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/stop.log

    chmod -R 755 /appl/IBM/HTTPServer
    chown -R webadm:webgrp /appl/IBM/HTTPServer
}

restart() {

    chmod -R 755 /appl/IBM/HTTPServer
    chown -R webadm:webgrp /appl/IBM/HTTPServer

    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log
    echo " ********************* IBM HTTPServer restarted at $Date *********************" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log
    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log

    echo "IBM HTTPServer Process :-" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log
    sudo -u ${SUDO_IHS_USER} -i ${RESTART_SERVER} >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log
    process=$(ps -ef|grep -i httpd)
    echo $process >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log

    echo "                                                                              " >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log
    echo " *******************************************************************************************" >> /appl/IBM/HTTPServer/logs/AutoStartupLogs/restart.log

    chmod -R 755 /appl/IBM/HTTPServer
    chown -R webadm:webgrp /appl/IBM/HTTPServer

}

case $1 in
    start|stop|restart) "$1" ;;
esac


