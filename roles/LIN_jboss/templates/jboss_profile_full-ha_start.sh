#!/bin/bash

#User to start JBoss services
SUDO_JBOSS_USER="jbossadm"


#Commands to start/stop JBoss servers
ip=`hostname -i`
START_SERVER="/appl/RH/jboss/bin/standalone.sh -c standalone-full-ha.xml &"
STOP_SERVER="/appl/RH/jboss/bin/jboss-cli.sh --connect --controller=$ip:9990 command=:shutdown"
RESTART_SERVER="/appl/RH/jboss/bin/jboss-cli.sh --connect --controller=$ip:9990 command=:restart"
Date=$(date +"%Y-%m-%d %H:%M:%S")

start() {

    chmod -R 755 /appl/RH
    chown -R jbossadm:jbossgrp /appl/RH

    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log
    echo " ********************* JBoss started at $Date *********************" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log
    echo "JBoss Process :-" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log
    #sudo -u ${SUDO_JBOSS_USER} -i ${START_SERVER} >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log 2>&1
    sudo -u ${SUDO_JBOSS_USER} -i /appl/RH/jboss/bin/standalone.sh -c standalone-full-ha.xml & >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log  2>&1
    sleep 10s
    process=$(ps -ef|grep -i java|grep -i jboss)
    echo $process >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log

    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log
    echo " *******************************************************************************************" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/start.log

    chmod -R 755 /appl/RH
    chown -R jbossadm:jbossgrp /appl/RH

}

stop() {

    chmod -R 755 /appl/RH
    chown -R jbossadm:jbossgrp /appl/RH

    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo " ********************* JBoss stopped at $Date *********************" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo " Below is the JBoss process before stopping "  >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    process_start=$(ps -ef|grep -i java|grep -i jboss)
    echo $process_start >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log

    sudo -u ${SUDO_JBOSS_USER} -i ${STOP_SERVER} >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo " JBoss process stopped successfully .."  >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log
    echo " *******************************************************************************************" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/stop.log

    chmod -R 755 /appl/RH
    chown -R jbossadm:jbossgrp /appl/RH
}

restart() {

    chmod -R 755 /appl/RH
    chown -R jbossadm:jbossgrp /appl/RH

    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log
    echo " ********************* JBoss restarted at $Date *********************" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log

    echo "JBoss Process :-" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log
    sudo -u ${SUDO_JBOSS_USER} -i ${STOP_SERVER} >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log  2>&1
    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log
    sudo -u ${SUDO_JBOSS_USER} -i /appl/RH/jboss/bin/standalone.sh -c standalone-full-ha.xml & >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log  2>&1
    process=$(ps -ef|grep -i java|grep -i jboss)
    echo $process >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log

    echo "                                                                              " >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log
    echo " *******************************************************************************************" >> /appl/RH/jboss/standalone/log/AutoStartupLogs/restart.log

    chmod -R 755 /appl/RH
    chown -R jbossadm:jbossgrp /appl/RH

}

case $1 in
    start|stop|restart) "$1" ;;
esac


