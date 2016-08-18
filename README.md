# pf-emerging-threats


copy all the files in the repository to the absolute paths as spcified.


copy update-et.sh to the home dir of the user who will run the script


make the script executable:

`$ chmod 744 update-et.sh`


run the update script to fetch the latest version of emerging-Block-IPs.txt:

`$ sudo ./update-et.sh`


alternatively you could execute the follwing commands in sequence:

`curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt`

`sudo cp /tmp/emerging-Block-IPs.txt /etc`

`sudo chmod 644 /etc/emerging-Block-IPs.txt`

