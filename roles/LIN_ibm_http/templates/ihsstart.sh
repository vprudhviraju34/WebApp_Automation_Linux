#!/bin/bash

chmod -R 755 /appl/IBM
chown -R webadm:webgrp /appl/IBM

su - webadm -c "cd /appl/IBM/HTTPServer/bin;./apachectl -k start"

chmod -R 755 /appl/IBM
chown -R webadm:webgrp /appl/IBM
