#!/usr/bin/python

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.link import TCLink
from mininet.util import dumpNodeConnections
from mininet.node import CPULimitedHost
from mininet.log import setLogLevel
from mininet.cli import CLI

import sys

# Topology for Mini-Project 3: Industrial Control System Topology
class ICSTopo(Topo):
    def __init__(self, cpu=.1, max_queue_size=None, **params):

        # Initialize topo
        Topo.__init__(self, **params)

        # Host and link configuration
        hostConfig = {'cpu': cpu}
        linkConfig = {'bw': 10, 'delay': '1ms', 'loss': 0,
                   'max_queue_size': max_queue_size }

        # Hosts and switches
        s1 = self.addSwitch('s1')
        h40 = self.addHost('h40', **hostConfig)
        h41 = self.addHost('h41', **hostConfig)
        #########################################
        #Add your hosts here
        

        # Wire Network
        self.addLink(h40, s1, **linkConfig)
        self.addLink(h41, s1, **linkConfig)
        #########################################
		#Add your links here


# Creates an instance of the topology defined above, starts it, and either starts the 
# student code or launches the command Line interface (CLI)
def runSimulation():    
    # Instantiate the network
    topo = ICSTopo()
    net = Mininet(topo=topo, host=CPULimitedHost, link=TCLink)
    
    # Set IP addresses
    h40 = net.get('h40')
    h40.setIP('192.168.1.40', 24)

    #########################################
    #set ip addresses of your other hosts here
    

    # Start Mininet
    net.start()
      
    
    # Test Network connectivity
    print "Testing network connectivity"
    #for testing only
    packet_loss_error = net.pingAll()
    # If the parameter '--clean' is specified, start CLI without any slaves running
    if len(sys.argv) > 1 and sys.argv[1] == "--clean":
        print "Starting the CLI - Clean"
        CLI(net)
    # Otherwise, run the simulation in automatic mode: Starts the slaves automatically
    else:
        print "Running simulation - starting slaves automatically"
        
        h41.cmd('python ./tcp_slave.py {} >& /root/slave{}.log 2>&1 &'.format(41, 41))
        #########################################
        # Start any other slave(s) here
        

        #########################################
        # Start the master device with the following command at the CLI:
        # h40 python ./tcp_master.py
        CLI(net)                    
    
    net.stop()

# Main Method:  Sets appropriate log level and initiates the simulation.
if __name__ == '__main__':
    setLogLevel('output')
    runSimulation()
