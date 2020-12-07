#!/bin/bash

chmod -R 755 /appl/IBM
chown -R wasadm:wasgrp /appl/IBM

su - wasadm -c " /appl/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh Server1"

chmod -R 755 /appl/IBM
chown -R wasadm:wasgrp /appl/IBM
