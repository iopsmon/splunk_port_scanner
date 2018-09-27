#!/usr/bin/perl
#+-------------------------------------------------------------------------------+
#DESCRIPTION: This will port scan all your splunk servers and produce a report  
#USE:perl dc_splunk_port_scan.pl  
#DATE:26/09/2018
#AUTHOR:Deepak Chohan
#VERSION:
#+-------------------------------------------------------------------------------+
#
#
#
use strict; 
use warnings;
use Net::Ping; 
use IO::Socket;
use Term::ANSIColor;
use 5.010;



#Start of Variables
my $file = "./all_splunk_servers.txt" ;
my $output = '';
my $host; 
my $timeout = 10;


#These are well known splunk ports - checks that these are the ones as per design, or change below
my @well_known_ports = qw( 8000 9997 8089 8189 514 1514 443 9001 9002 );
#End of my variables


#Read the file which should contain all your splunk servers 
open (MYHOSTSFILE, "<", "$file") or die $!;


#Code Start
#ping servers belonging to the opsa_server array group
sub ping_hosts {
	while (my @lines = <MYHOSTSFILE>) 
		{ 
		foreach $host (@lines) 
		{
		print "Pinging $host\n";
		my $p = Net::Ping ->new("icmp"); #create ping object
		chomp $host;
		if ( $p-> ping ($host) ) 
		{	 
		 print color ('bold green');
		 print "+------------------------------------------+\n";  	
		 print "Host ".$host."  is alive\n";
		 my $aliveoutput = "Host ".$host." is alive\n";
		 print "\n";
		 print color ('reset');
 		  foreach my $port (@well_known_ports)
	 	  {
           my  $socket = IO::Socket::INET->new(PeerAddr => $host , PeerPort => $port , Proto => 'tcp' , Timeout => 5);
            if($socket )
              {
		      print color ('bold green');
              print "Port: $port on $host is open.\n";
			  my $openport = "Port: $port on $host is open.\n";
		   	  my $portrpt = "$port $host\n";
			  print color ('reset');
               }
                else
               {
                print  "Port: $port on $host is closed.\n";
               }
		        }
                 } 
		       else
		      { 	
		      print color ('bold red');
		      print "+------------------------------------------+\n";
              print "Warning: ".$host." is offline\n";
              print "\n";
              print color ('reset');
		    }	
		  }	
    	}
	  } 

#Run the functions
ping_hosts;
print $output;
close MYHOSTSFILE; 
exit (0);
#End of Code
