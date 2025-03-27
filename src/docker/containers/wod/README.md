# docker-windows

## About

This setup effectively creates a Windows virtual machine running inside a Docker container with hardware acceleration, proper networking, and GPU capabilities.

### Use Cases

When you need Windows, but you only need it for a short time. Or when you want to keep a Windows installation, but you don't want to dedicate an entire physical system to the operating system. 

With Windows inside a Docker container it is possible to run full Windows applications in a sandbox environment using Zero Trust principles. 

The network configuration supports IPv4, IPv6, static or dynamic address assignment, Docker IPVLAN, Docker MACVLAN, and may other options for Zero Trust micro- and nano-segmentation solutions. 

The display configuration supports GPU assignment through the Docker NVIDIA runtime service. 

Audio and microphone passthrough are supported. 

|Feature|Supported|
|-|-|
|1 or More vCPUs|X|
|RAM|X|
|1 or More GPUs|X|
|Persistent Volumes|X|
|Custom Volumes|X|
|Network Share|X|
|USB Passthrough|X|
|Audio|X|
|Recording|X|
|Other?| |

### Source

https://github.com/youngsecurity/docker-windows

#### Explanation of the devices Section in the Windows Docker Container

The devices section in the docker-compose.yml file maps host device files into the container, giving the container direct access to specific hardware or kernel features. For this Windows container, three critical devices are mapped:

1. `/dev/kvm` **(Kernel-based Virtual Machine)**
This provides access to the KVM virtualization infrastructure in the Linux kernel
Essential for hardware-accelerated virtualization within the container
Allows the Windows VM to run with near-native performance by utilizing CPU virtualization extensions (Intel VT-x or AMD-V)
Without this, the Windows VM would run significantly slower using pure emulation

2. `/dev/net/tun` **(Network TUNnel)**
Provides a kernel network interface for creating virtual network devices
Enables the container to create and manage virtual network interfaces
Required for setting up networking between the host and the Windows VM
Works with the NET_ADMIN capability to allow network configuration

3. `/dev/vhost-net` **(Vhost Network Device)**
Accelerates virtio networking performance
Specifically marked as "required for DHCP" in your configuration
Works with the device_cgroup_rules entry to enable proper network functionality
Allows for efficient network I/O between the host and the virtualized Windows system
These device mappings work together with other configuration elements:

The `cap_add: - NET_ADMIN` grants network administration privileges

The `device_cgroup_rules: - 'c *:* rwm'` allows character device access (also noted as required for DHCP)

The networks section configures both proxy and macvlan networking with a static IP

Additionally, the configuration includes GPU passthrough via the deploy section, which reserves an NVIDIA GPU (device 0) for the Windows VM, allowing Windows applications to utilize the GPU's processing power.
