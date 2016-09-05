# pf-setup

## initial setup


copy the file /etc/[pf.conf](/etc/pf.conf) to `/etc/pf.conf`

copy the file /etc/pf.anchors/[emerging-threats](/etc/pf.anchors/emerging-threats) to `/etc/pf.anchors/emerging-threats`

copy the file /etc/pf.anchors/[rea_corp](/etc/pf.anchors/rea_corp) to `/etc/pf.anchors/rea_corp`

copy the file /etc/[rea_dc.txt](/etc/rea_dc.txt) to `/etc/rea_dc.txt`

copy [update-et.sh](update-et.sh) to the home dir of the user who will run the script


make the script executable:

    $ chmod 655 update-et.sh


run the update script to fetch the latest version of emerging-Block-IPs.txt:

    $ sudo ./update-et.sh


alternatively you could execute the follwing commands in sequence:

    curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
    sudo cp /tmp/emerging-Block-IPs.txt /etc
    sudo chmod 644 /etc/emerging-Block-IPs.txt
    rm /tmp/emerging-Block-IPs.txt
    
test the config prior to rebooting:

    $ sudo pfctl -v -n -f /etc/pf.conf
    
load the config:

    $ sudo pfctl -f /etc/pf.conf


## reboot


test that that pf has picked up the new rule set:

    $ sudo pfctl -a 'emerging-threats' -sr

    $ sudo pfctl -a 'rea_corp' -sr


you should see:

    No ALTQ support in kernel
    ALTQ related functions disabled
    block drop log from any to <emerging_threats>


test that the table has been populated:

    $ sudo pfctl -a 'emerging-threats' -t 'emerging_threats' -Tshow


## setup logging to file /var/log/pf.log

### syslogd configuration

copy the file [pflog](/etc/asl/pflog) to `/etc/asl/pflog`

gently restart the syslogd

    $ sudo killall -HUP syslogd


### pflogd missing in Mac OS X

copy [pflog.sh](pflog.sh) to `/opt/pf/pflog.sh`

make the script executable:

    $ sudo chmod 655 /opt/pf/pflog.sh


copy [pflog.plist](pflog.plist) to `/Library/LaunchDaemons/pflog.plist`

load the launch config

    $ sudo launchctl load /Library/LaunchDaemons/pflog.plist


check that the config has loaded and started 

    $ sudo launchctl list | grep pflog

    8271	0	pflog


check that the interface pflog0 has been created

    $ ifconfig pflog0

    pflog0: flags=141<UP,RUNNING,PROMISC> mtu 33080


check that the logger is running

    $ ps aux | grep logger

    root             8274   0.0  0.0  2437900    712   ??  S     3:51PM   0:00.01 /usr/bin/logger -t pf -p 6


you should now see the log file created and being written to `/var/log/pf.log`


# credits

	https://discussions.apple.com/thread/3346500?tstart=0
	https://ikawnoclast.com/security/mac-os-x-pf-firewall-avoiding-known-bad-guys/
