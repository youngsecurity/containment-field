terraform {  
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  # Configuration options
  host = "unix:///var/run/docker.sock"
  #host = "tcp://10.0.255.19:2375/"
}

# Pull the Docker image
resource "docker_image" "docker-osx-ventura" {
  name = "docker-osx-ventura:latest"
}

data "docker_image" "latest" {
  name = "docker-osx-ventura"
}

# Reference the existing external volume
resource "docker_volume" "macos_sickcodes_disk_1" {
  name = "macos_sickcodes_disk_1"
}

# Reference the existing external network
resource "docker_network" "macvlan255" {
  name = "macvlan255"
  driver = "macvlan"

  lifecycle {
    prevent_destroy = true
  }
}

data "docker_network" "macvlan255" {
  name = "macvlan255"  
}

# Create the Docker container
resource "docker_container" "macos_sickcodes" {  
  image = docker_image.docker-osx-ventura.image_id
  name  = "macos_sickcodes"

  # Add capabilities
  capabilities {
    add = ["NET_ADMIN"]
  } 

  # Set environment variables
  env = [
    "DISPLAY=$${DISPLAY:-:0.0}",    
    "GENERATE_UNIQUE=true",
    #"CPU='Haswell-noTSX'",
    #"CPUID_FLAGS='kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on'",
    #"MASTER_PLIST_URL='https://raw.githubusercontent.com/sickcodes/osx-serial-generator/master/config-custom-sonoma.plist'",
    "SIZE=64G",
    "CORES=4",
    "SMP=4",
    "RAM=8",
  ]

  # Add devices
  devices {
    host_path      = "/dev/kvm"
    container_path = "/dev/kvm"
  }
  devices {
    host_path      = "/dev/net/tun"
    container_path = "/dev/net/tun"
  }

  # Healthcheck
  #healthcheck {
  #  test = ["CMD", "curl", "-f", "http://10.0.255.156:8006"]
  #  interval = "30s"
  #  timeout = "10s"
  #  retries = "3"
  #}

  # Map ports # not reqired when using a MACVLAN
  #ports {
  #  internal = 8006
  #  external = 8006
  #}
  #ports {
  #  internal = 5900
  #  external = 5900
  #  protocol = "tcp"
  #}
  #ports {
  #  internal = 5900
  #  external = 5900
  #  protocol = "udp"
  #}

  # Mount the external volume
  mounts {
    target = "/storage"
    source = resource.docker_volume.macos_sickcodes_disk_1.name
    type   = "volume"
  }

  # Mount /tmp/.X11-unix from the host to the container
  mounts {
    target = "/tmp/.X11-unix"
    source = "/tmp/.X11-unix"
    type   = "bind"
  }

  # Connect to the external network with a static IP
  networks_advanced {
    name         = data.docker_network.macvlan255.name
    ipv4_address = "10.0.255.156"
  }

  # Set the restart policy
  restart = "unless-stopped"

  # Set the stop timeout (in seconds)
  stop_timeout = 120
}