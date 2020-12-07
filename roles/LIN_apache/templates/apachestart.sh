#!/bin/bash

chmod -R 755 /appl/freeware
chown -R webadm:webgrp /appl/freeware

su - webadm -c "cd /appl/freeware/apache/bin;./apachectl -k start"

chmod -R 755 /appl/freeware
chown -R webadm:webgrp /appl/freeware
