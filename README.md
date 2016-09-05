# pf-setup


## initial setup


copy the file /etc/[pf.conf](/etc/pf.conf) to `/etc/pf.conf`

copy the file /etc/pf.anchors/[emerging-threats](/etc/pf.anchors/emerging-threats) to `/etc/pf.anchors/emerging-threats`

copy [update-et.sh](update-et.sh) to the home dir of the user who will run the script or to `/opt/pf/update-et.sh`

make the script executable:

	$ chmod 644 update-et.sh


run the update script to fetch the latest version of emerging-Block-IPs.txt:

	$ sudo /opt/pf/update-et.sh


alternatively you could execute the follwing commands in sequence:

	curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
	sudo cp /tmp/emerging-Block-IPs.txt /opt/pf
	sudo chmod 644 /opt/pf/emerging-Block-IPs.txt
	rm /tmp/emerging-Block-IPs.txt

    
test the config prior to rebooting:

	$ sudo pfctl -v -n -f /etc/pf.conf

    
load the config and enable the pf firewall:

	$ sudo pfctl -f -e /etc/pf.conf


### auto-start pf firewall on boot up


Some paths and applications in El Capitan are protected by System Integrity Protection. Even root can't modify the files. You first have to disable SIP before editing or modifying them.


Reboot your Mac to Recovery Mode by restarting your computer and holding down `Command` `R` until the Apple logo appears on your screen.

Click Utilities -> Terminal.

In the Terminal window, enter in `csrutil disable` and press Enter.

Restart your Mac

Modify the file(s)

Update the lauch configuration file to include the `-e` flag to the startup script `/System/Library/LaunchDaemons/com.apple.pfctl.plist`, see the example in [com.apple.pfctl.plist](com.apple.pfctl.plist)

Reboot your Mac to Recovery Mode by restarting your computer and holding down `Command` `R` until the Apple logo appears on your screen.

Click Utilities -> Terminal.

In the Terminal window, enter in `csrutil enable` and press Enter.

Restart your Mac


## reboot


test that that pf has picked up the new rule set:

	$ sudo pfctl -a 'emerging-threats' -sr


you should see:

	No ALTQ support in kernel
	ALTQ related functions disabled
	block drop log from any to <emerging_threats>


test that the table has been populated:

	$ sudo pfctl -a 'emerging-threats' -t 'emerging_threats' -Tshow


## setup logging to file /var/log/pf.log


### syslogd configuration


copy the file [rea.pflog](/etc/asl/rea.pflog) to `/etc/asl/rea.pflog`

gently restart the syslogd

	$ sudo killall -HUP syslogd


### pflogd missing in Mac OS X


copy [pflog.sh](pflog.sh) to `/opt/pf/pflog.sh`

make the script executable:

	$ sudo chmod 644 /opt/pf/pflog.sh


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


# reference/credits

	https://discussions.apple.com/thread/3346500?tstart=0
	https://ikawnoclast.com/security/mac-os-x-pf-firewall-avoiding-known-bad-guys/
