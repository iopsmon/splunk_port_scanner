# splunk_port_scanner
scans splunk common ports

1. The script will scan all the common Splunk ports, and some ports of course will be disabled or 
not required on the Splunk server. So you must know which ones should be open or valid for the type of Splunk function. 

2. If you want to add any new or customised ports, then edit the perl script and add the ports into 
the my @well_known_ports section. 

3. The script can also be used as part of a port scanning test. 

 
INSTALL:
1. Copy this script to the /tmp or home folder on the linux server 
2. Add all your splunk FQDN or IP address into the file called all_splunk_servers.txt - ensure there are no spaces after the names or hidden characters.
3. Run chmod +x ./dc_splunk_port_scan.pl 
4. Run sudo perl ./dc_splunk_port_scan.pl
