#!/bin/sh
# bodged solution to absence of pflogd, ref 'Book of PF' p136
ifconfig pflog0 create
/usr/sbin/tcpdump -lnettti pflog0 | /usr/bin/logger -t pf -p local2.info
