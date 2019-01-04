This section covers how to install the standard network time protocol (NTP), and describes two different NTP configurations that have worked in our test beds. 

# NTP

Time synchronization between nodes is critical for OpenPtrack to work. NTP daemon is sufficient for this.  

Currently, detections must have a window of no greater than 1 video frame (at 30 fps, about 33 ms) and, ideally, far less to produce valid tracking. In practical systems, we aim for less than a 10 ms offset and jitter, as reported by NTP, before starting calibration or tracking. 

A common symptom of poor host synchronization is `splitting` (that is, one person being shown as two detections). 

### Time Synchronization

OpenPTrack multi-camera integration requires time synchronization on every host CPU. For the target platform (Ubuntu), using NTP in the following configuration is recommended. Once a machine is chosen to be the server, the other CPUs will listen for time synchronization. 

First, you should have installed NTP during the [installation steps](https://github.com/OpenPTrack/open_ptrack_v2/wiki/OpenPTrack-v2-Modules#ntp) 

**N.B.:** If you are using the [Docker Images](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Docker-Images), run the following in your host machine (not container):

   `sudo apt-get install ntp -y`


With NTP installed, edit the client & server configuration files. 

**N.B.:** We have successfully used two NTP configurations. The first configuration has been used in smaller networks, five or less CPUs. This configuration also normalizes the time on each CPU faster; the offset converges quickly. The second configuration has been used in larger networks, more than five CPUs. We have found this configuration to be more stable over larger networks; the offset is less likely to drift, but the time across the network takes longer to converge. This configuration must be done on the machine and not in the container even if you are running [Docker Images](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Docker-Images). 

## Configuration 1

**server: /etc/ntp.conf:**

    filegen peerstats file peerstats type day enable
    filegen clockstats file clockstats type day enable
    
    # Specify one or more NTP servers.
    
    # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
    # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
    # more information.
    #server 0.ubuntu.pool.ntp.org
    #server 1.ubuntu.pool.ntp.org
    #server 2.ubuntu.pool.ntp.org
    #server 3.ubuntu.pool.ntp.org
    #server 0.north-america.pool.ntp.org iburst
    server ntp.ucla.edu
    server 127.127.1.0
    fudge 127.127.1.0 stratum 10
    
    
    # Use Ubuntu's ntp server as a fallback.
    #server ntp.ubuntu.com

    # Access control configuration; see /usr/share/doc/ntp-doc/html/accopt.html for
    # details.  The web page <http://support.ntp.org/bin/view/Support/AccessRestrictions>
    # might also be helpful.
    #
    # Note that "restrict" applies to both servers and clients, so a configuration
    # that might be intended to block requests from certain clients could also end
    # up blocking replies from your own upstream servers.
    
    # By default, exchange time with everybody, but don't allow configuration.
    #restrict -4 default kod notrap nomodify nopeer noquery
    #restrict -6 default kod notrap nomodify nopeer noquery
    
    # Local users may interrogate the ntp server more closely.
    #restrict 127.0.0.1
    #restrict ::1
    restrict 192.168.100.0 mask 255.255.255.0 nomodify notrap
    
    # Clients from this (example!) subnet have unlimited access, but only if
    # cryptographically authenticated.
    #restrict 192.168.123.0 mask 255.255.255.0 notrust


    # If you want to provide time to your local subnet, change the next line.
    # (Again, the address is an example only.)
    #broadcast 192.168.123.255
    
    # If you want to listen to time broadcasts on your local subnet, de-comment the
    # next lines.  Please do this only if you trust everybody on the network!
    #disable auth
    #broadcastclient
    broadcast 192.168.100.255

For other nodes to sync to this master, and if the master is not online, comment out the first external server. Please note that this assumes a 192.168.100.X network (if necessary, change the broadcast to match the network).

**client: /etc/ntp.conf:**

There is a lot of other "stuff" on the client that has to be removed. Some settings interfere with the ultimately simple goal of syncing the slave/client to a master on the LAN. To that end, replace the `/etc/ntp.conf` file entirely with the following:

    # /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help
    driftfile /var/lib/ntp/ntp.drift
    # Enable this if you want statistics to be logged.
    #statsdir /var/log/ntpstats/
    statistics loopstats peerstats clockstats
    filegen loopstats file loopstats type day enable
    filegen peerstats file peerstats type day enable
    filegen clockstats file clockstats type day enable
    # Specify one or more NTP servers.
    server 192.168.100.101 iburst
    disable auth
    broadcastclient

192.168.100.101 must be changed to the IP of the chosen master / LAN time server. 

The client `ntp.conf` needs to be added to all other non-master nodes. 

## Configuration 2

**server: /etc/ntp.conf:**

    driftfile /var/lib/ntp/ntp.drift
    
    # Enable this if you want statistics to be logged.
    statsdir /var/log/ntpstats/
    
    statistics loopstats peerstats clockstats
    filegen loopstats file loopstats type day enable
    filegen peerstats file peerstats type day enable
    filegen clockstats file clockstats type day enable
    
    # Specify one or more NTP servers.
    
    # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
    # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
    # more information.
    
    #server 64.67.62.194 iburst
    
    # Do not use a low minpoll/maxpoll, to keep things typical to outside world
    server time1.ucla.edu iburst
    server time2.ucla.edu iburst
    
    peer 192.168.100.102 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.103 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.104 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.105 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.106 minpoll 4 maxpoll 6 iburst

    # We are the master, so listen on the subnet but no modification
    restrict 192.168.100.0 mask 255.255.255.0 

    # Local users may interrogate the ntp server more closely.
    # Needed for ntpq if we use restrict default ignore
    restrict 127.0.0.1
    restrict ::1

**N.B:** In the above configuration, three portions of the code need to be changed:

### Portion One

    # Do not use a low minpoll/maxpoll, to keep things typical to outside world
    server time1.ucla.edu iburst
    server time2.ucla.edu iburst

The two UCLA NTP servers should be changed to the NTP servers closest to where your installation is physically located.

### Portion Two 

    peer 192.168.100.102 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.103 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.104 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.105 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.106 minpoll 4 maxpoll 6 iburst

The peers should reflect the CPUs in your network that are not acting as the server machine. The network this reflects has six CPUs; the master's IP address is 192.168.100.101; the peer IP addresses are 192.168.100.102 - .106.

### Portion Three

     # We are the master, so listen on the subnet but no modification
     restrict 192.168.100.0 mask 255.255.255.0 

The 192.168.100.0 should reflect the subnet that your network is set to, i.e, if your subnet is .0, your code will be:

     # We are the master, so listen on the subnet but no modification
     restrict 192.168.0.0 mask 255.255.255.0 

**client: /etc/ntp.conf:**

    #/etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help
    
    driftfile /var/lib/ntp/ntp.drift
    
    # Enable this if you want statistics to be logged.
    statsdir /var/log/ntpstats/
    statistics loopstats peerstats clockstats
    filegen loopstats file loopstats type day enable
    filegen peerstats file peerstats type day enable
    filegen clockstats file clockstats type day enable
    
    # Restrict what we listen to
    restrict default ignore
    
    # We are a peer so allow devices on the subnet to modify
    restrict 192.168.100.0 mask 255.255.255.0
    
    # Local users may interrogate the ntp server more closely.
    # Needed for ntpq if we use restrict default ignore
    restrict 127.0.0.1
    restrict ::1
    
    # Sync with our peers
    ## NOTE THIS MUST BE EDITED PER MACHINE
    ## TO LIST OTHER PEERS, THIS IS AN EXAMPLE
    ## FOR 102
    peer 192.168.100.101 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.103 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.104 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.105 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.106 minpoll 4 maxpoll 6 iburst

**N.B.:** Again, there are two changes that need to be made:

### Change One

     # We are the master, so listen on the subnet but no modification
     restrict 192.168.100.0 mask 255.255.255.0 

The 192.168.100.0 should reflect the subnet that your network is set to, i.e, if your subnet is .0, your code will be:

     # We are the master, so listen on the subnet but no modification
     restrict 192.168.0.0 mask 255.255.255.0

### Change Two

    peer 192.168.100.102 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.103 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.104 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.105 minpoll 4 maxpoll 6 iburst
    peer 192.168.100.106 minpoll 4 maxpoll 6 iburst

The peers should reflect the CPUs in your network that are not acting as the server machine. The network this reflects has six CPUs; the master's IP address is 192.168.100.101; the peer IP addresses are 192.168.100.102 - .106.

**Configuration is complete!** But to confirm synchronization (after configuration, this will only work on Configuration 1): 
    
NTP reconciliation is gradual, but the `iburst` setting above accelerates convergence to 5-10 seconds.         Although not necessary, but if impatient: 

    sudo service ntp stop
    sudo ntpd -gq
    sudo service ntp start
   
And while also not necessary, to start every time on system start (which will add a few seconds to boot time), in `/etc/rc.local`, put:

    /etc/init.d/ntp stop
    until ping -nq -c3 8.8.8.8; do
    echo "Waiting for network..."
    done
    ntpd -gq
    /etc/init.d/ntp start )&

**To verify that NTP has converged:**

##  Configuration 1 Verification

Regardless, to confirm time synchronization, per host type:

    ntpq --peers

The master should display the following or similar:

     	remote       	refid  	st t when poll reach   delay   offset  jitter
    ==============================================================================
    *0.north-america.p  .GPS.        	1 u	8   64  377   25.118   -2.756   2.843
     LOCAL(0)    	.LOCL.      	10 l 1164   64	0	0.000	0.000   0.000
     192.168.100.255 .BCST.      	16 u	-   64	0	0.000	0.000   0.000

Peers should display the following or similar:

    	remote       	refid  	st t when poll reach   delay   offset  jitter
    ==============================================================================
    *opt-node-4.loca 164.67.62.199	2 u	2   64   37	0.078   -1.867   1.670

## Configuration 2 Verification

One the server machine, run:

    ntpq -p

The master should display the following or similar:

         remote           refid      st t when poll reach   delay   offset  jitter
    ==============================================================================
    +time1.ucla.edu  .GPS.            1 u   13   64    7    1.017    1.382   0.132
    *time2.ucla.edu  .GPS.            1 u   13   64    7    0.677    1.292   0.159
     o2              192.168.100.101  3 u   18   16    2    2.745  -24.158  62.103
     o3              192.168.100.101  3 u    1   16    0    0.000    0.000   0.000
     o4              192.168.100.101  3 u   21   16    2    0.389   65.593  33.983
     o5              192.168.100.101  3 u    4   16   77    4.893   -5.649  54.487
     o6              192.168.100.101  3 u    6   16   76    0.357   25.253  15.913

**Phew! Nodes are now synced.** It was worth the effort: The better the synchronization, the better the tracking. 