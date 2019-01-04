# Basic Network Configuration

This section covers the basic configuration of the Gigabit network to which the OpenPTrack master and all peers need to be connected, as well as basic best practices to be used regarding networking.  

We have found reliability in using a topology and IP configuration similar to the following:

![Networking_Example](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/OPT_Networking_Example.jpg?raw=true)

**N.B.:** In our typical setups, the SwissRanger is on a second network interface (NIC) card, allowing it to be on a separate segment. (This is done to conserve bandwidth on the OPT LAN, and is particularly important for high-bandwidth devices, such as the Point Grey GigE cameras.)