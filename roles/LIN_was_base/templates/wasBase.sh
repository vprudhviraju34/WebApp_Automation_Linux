#!/bin/bash

#User to start WebSphere services
SUDO_WAS_USER="wasadm"

#User and pass to shutdown WebSphere services
#WAS_ADMIN_USER="wasadmin"
#WAS_ADMIN_PASS="j2eewas100"

#Commands to start/stop WebSphere servers
START_SERVER="/appl/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh Server1"
STOP_SERVER="/appl/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopServer.sh Server1"
#STOP_SERVER="/appl/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopServer.sh Server1 -username ${WAS_ADMIN_USER} -password ${WAS_ADMIN_PASS}"

Date=$(date +"%Y-%m-%d %H:%M:%S")

start() {

    chmod -R 755 /appl/IBM/
    chown -R wasadm:wasgrp /appl/IBM/


    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Start.log
    echo " ********************* WAS Base Server1 started at $Date *********************" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Start.log
    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Start.log

    sudo -u ${SUDO_WAS_USER} -i ${START_SERVER} >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Start.log

    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Start.log
    echo " *******************************************************************************************" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Start.log

    chmod -R 755 /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/
    chown -R wasadm:wasgrp /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/
}

stop() {

    chmod -R 755 /appl/IBM/
    chown -R wasadm:wasgrp /appl/IBM/

    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Stop.log
    echo " ********************* WAS Base Server1 stopped at $Date *********************" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Stop.log
    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Stop.log

    sudo -u ${SUDO_WAS_USER} -i ${STOP_SERVER} >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Stop.log

    echo "                                                                              " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Stop.log
    echo " *******************************************************************************************" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Stop.log


    chmod -R 755 /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/
    chown -R wasadm:wasgrp /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/
}


restart() {

    chmod -R 755 /appl/IBM/
    chown -R wasadm:wasgrp /appl/IBM/

	echo "                                                                                " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Restart.log
    echo " ********************* WAS Base Server1 restarted at $Date *********************" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Restart.log
    echo "                                                                                " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Restart.log

    sudo -u ${SUDO_WAS_USER} -i ${STOP_SERVER} >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Restart.log
    sudo -u ${SUDO_WAS_USER} -i ${START_SERVER} >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Restart.log

    echo "                                                                                " >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Restart.log
    echo " *******************************************************************************************" >> /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/server1Restart.log

    chmod -R 755 /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/
    chown -R wasadm:wasgrp /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/AutoStartupLogs/

}


case $1 in
    start|stop|restart) "$1" ;;
esac
