# pf-setup


## initial setup


copy the file /etc/[pf.conf](/etc/pf.conf) to `/etc/pf.conf`

copy the file /etc/pf.anchors/[emerging-threats](/etc/pf.anchors/emerging-threats) to `/etc/pf.anchors/emerging-threats`

copy /opt/pf/[update-et.sh](/opt/pf/update-et.sh) to the home dir of the user who will run the script or to `/opt/pf/update-et.sh`

make the script executable:

	$ chmod 540 /opt/pf/update-et.sh


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

	$ sudo pfctl -e -f /etc/pf.conf


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


test that pf has picked up the new rule set:

	$ sudo pfctl -sr


you should see the rules listed such as:

	No ALTQ support in kernel
	ALTQ related functions disabled
	scrub-anchor "com.apple/*" all fragment reassemble
	anchor "com.apple/*" all
	anchor "emerging-threats" all


test that the table has been populated:

	$ sudo pfctl -a 'emerging-threats' -t 'emerging_threats' -Tshow



## Create the pflog0 interface

	$ sudo ifconfig pflog0 create

Use a tool such as Wireshark to view the log entries written to pflog0


# reference/credits

	https://discussions.apple.com/thread/3346500?tstart=0
	https://ikawnoclast.com/security/mac-os-x-pf-firewall-avoiding-known-bad-guys/
