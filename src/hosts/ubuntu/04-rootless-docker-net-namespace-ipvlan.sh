# Creating an ipvlan network on rootless Docker involves a few steps:

# First, you need to create a network namespace for the container to use:
ip netns add <namespace-name>
# This command creates a new network namespace with the specified name.

# Next, create an ipvlan interface that is attached to your physical network interface:
ip link add <interface-name> link <physical-interface> type ipvlan mode l2
# Replace <interface-name> with the name you want to give to the ipvlan interface, 
# and <physical-interface> with the name of the physical network interface that you want to attach the ipvlan interface to.

# Note: the mode l2 option means that the interface will operate at Layer 2, which is necessary for ipvlan.

# Move the ipvlan interface into the container's network namespace:

ip link set <interface-name> netns <namespace-name>
# This command moves the ipvlan interface into the network namespace that you created in step 1.

# Inside the container, configure the ipvlan interface with an IP address:

ip addr add <ip-address>/<netmask> dev <interface-name>
# Replace <ip-address>/<netmask> with the IP address and netmask that you want to assign to the ipvlan interface, 
# and <interface-name> with the name you gave to the ipvlan interface in step 2.

# With these steps, you should now have an ipvlan network set up for your rootless Docker container. 
# To start a container using this network, you can use the --net=container:<container-id> option when running the docker run command. 
# This will attach the container to the ipvlan network created in the steps above.