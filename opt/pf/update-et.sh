#!/bin/sh
wc -l /opt/pf/emerging-Block-IPs.txt | logger -t pf -p 5
curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
cp /tmp/emerging-Block-IPs.txt /opt/pf
chmod 444 /opt/pf/emerging-Block-IPs.txt
wc -l /opt/pf/emerging-Block-IPs.txt | logger -t pf -p 5
rm /tmp/emerging-Block-IPs.txt
wc -l /opt/pf/compromised-ips.txt | logger -t pf -p 5
curl http://rules.emergingthreats.net/blockrules/compromised-ips.txt -o /tmp/compromised-ips.txt
cp /tmp/compromised-ips.txt /opt/pf
chmod 444 /opt/pf/compromised-ips.txt
wc -l /opt/pf/compromised-ips.txt | logger -t pf -p 5
rm /tmp/compromised-ips.txt
pfctl -f /etc/pf.conf
