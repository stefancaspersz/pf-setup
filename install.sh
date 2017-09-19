#!/bin/sh
cp etc/pf.conf /etc/pf.conf
cp etc/pf.anchors/emerging-threats /etc/pf.anchors/emerging-threats
cp etc/pf.anchors/compromised-ips /etc/pf.anchors/compromised-ips
mkdir ~/scripts/pf/
cp opt/pf/update-et.sh ~/scripts/pf/update.sh
chmod 540 scripts/pf/update-et.sh
sh ./scripts/pf/update.sh
pfctl -v -n -f /etc/pf.conf
pfctl -f -e /etc/pf.conf
ifconfig pflog0 create