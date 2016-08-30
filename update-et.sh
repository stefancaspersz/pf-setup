#!/bin/sh
wc -l /etc/emerging-Block-IPs.txt | logger -t pf -p 5
curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
cp /tmp/emerging-Block-IPs.txt /etc
chmod 644 /etc/emerging-Block-IPs.txt
wc -l /etc/emerging-Block-IPs.txt | logger -t pf -p 5
rm /tmp/emerging-Block-IPs.txt
pfctl -f /etc/pf.conf
