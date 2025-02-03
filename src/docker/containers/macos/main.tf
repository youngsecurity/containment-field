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
resource "docker_image" "macos_image" {
  name = "dockurr/macos:latest"
}

# Reference the existing external volume
resource "docker_volume" "dockurr_macos_disk_1" {
  name = "dockurr_macos_disk_1"
}

# Reference the existing external network
resource "docker_network" "macvlan255" {
  name = "macvlan255"
  driver = "macvlan"

  lifecycle {
    prevent_destroy = true
  }
}

# Create the Docker container
resource "docker_container" "macos_dockurr" {  
  image = docker_image.macos_image.image_id
  name  = "macos_dockurr"

  # Add capabilities
  capabilities {
    add = ["NET_ADMIN"]
  } 

  # Set environment variables
  env = [
    "VERSION=14",
    "DISK_SIZE=64G",
    "CPU_CORES=4",
    "RAM_SIZE=8GB",
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
  healthcheck {
    test = ["CMD", "curl", "-f", "http://10.0.255.156:8006"]
    interval = "30s"
    timeout = "10s"
    retries = "3"
  }

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
    source = resource.docker_volume.dockurr_macos_disk_1.name
    type   = "volume"
  }

  # Connect to the external network with a static IP
  networks_advanced {
    name         = resource.docker_network.macvlan255.name
    ipv4_address = "10.0.255.156"
  }

  # Set the restart policy
  restart = "unless-stopped"

  # Set the stop timeout (in seconds)
  stop_timeout = 120
}