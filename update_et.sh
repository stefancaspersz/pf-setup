#!/bin/sh
curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
cp /tmp/emerging-Block-IPs.txt /etc
chmod 644 /etc/emerging-Block-IPs.txt
