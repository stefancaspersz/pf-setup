# pf-emerging-threats

## initial setup


append the contents of [pf.conf](/etc/pf.conf) to the file `/etc/pf.conf`

copy the file [emerging-threats](/etc/pf.anchors/emerging-threats) to `/etc/pf.anchors/`

copy [update-et.sh](update-et.sh) to the home dir of the user who will run the script


make the script executable:

    $ chmod 744 update-et.sh


run the update script to fetch the latest version of emerging-Block-IPs.txt:

    $ sudo ./update-et.sh


alternatively you could execute the follwing commands in sequence:

    curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
    sudo cp /tmp/emerging-Block-IPs.txt /etc
    sudo chmod 644 /etc/emerging-Block-IPs.txt


test the config prior to rebooting:

    sudo pfctl -v -n -f /etc/pf.conf
    

## reboot


test that that pf has picked up the new rule set:

    $ sudo pfctl -a 'emerging-threats' -sr


you should see:

    No ALTQ support in kernel
    ALTQ related functions disabled
    block drop log from <emerging_threats> to any
    block drop log from any to <emerging_threats>


test that the table has been populated:

    $ sudo pfctl -a 'emerging-threats' -t 'emerging_threats' -Tshow


## setup monitoring


run the following commands to setup the logging interface and monitor the logging interface on the console:

    $ sudo ifconfig pflog0 create
    $ sudo tcpdump -n -e -ttt -i pflog0
