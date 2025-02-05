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
  host = "tcp://ignignokt.home.youngsecurity.net:2376/"  
  ca_material   = file(pathexpand("~/.docker/ca-docker.pem")) # this can be omitted
  cert_material = file(pathexpand("~/.docker/client-docker-cert.pem"))
  key_material  = file(pathexpand("~/.docker/key-docker-client.pem"))  
}

# Pull the Docker image
resource "docker_image" "open-webui" {
  name = "ghcr.io/open-webui/open-webui:0.5.9"
}

# Reference the existing external volume
resource "docker_volume" "ollama" {
  name = "ollama"
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
resource "docker_container" "open-webui" {  
  image = docker_image.open-webui.image_id
  name  = "open-webui"

  # Add capabilities
  #capabilities {
  #  add = ["NET_ADMIN"]
  #}

  hostname = "open-webui"
  
  gpus = "device=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c"

  tty = true

  # Set environment variables
  env = [
    "TZ=America/New_York",
    "OLLAMA_ORIGINS=moz-extension://*,chrome-extension://*,safari-web-extension://*",
  ]

  # Add devices
  #devices {
  #  host_path      = ""
  #  container_path = ""
  #}
  #devices {
  #  host_path      = ""
  #  container_path = ""
  #}

  # Healthcheck
  #healthcheck {
  #  test = ["CMD", "curl", "-f", "http://IP:PORT"]
  #  interval = "30s"
  #  timeout = "10s"
  #  retries = "3"
  #}

  # Map ports # not reqired when using a MACVLAN 
  #ports {
  #  internal = XXXX
  #  external = XXXX
  #  protocol = "tcp"
  #}
  #ports {
  #  internal = XXXX
  #  external = XXXX
  #  protocol = "udp"
  #}

  # Mount the external volume
  mounts {
    target = "/root/.ollama"
    source = resource.docker_volume.ollama.name
    type   = "volume"
  }

  # Mount /tmp/.X11-unix from the host to the container
  #mounts {
  #  target = "/tmp/.X11-unix"
  #  source = "/tmp/.X11-unix"
  #  type   = "bind"
  #}

  # Connect to the external network with a static IP
  networks_advanced {
    name         = data.docker_network.macvlan255.name
    ipv4_address = "10.0.255.148"
  }

  # Set the restart policy
  restart = "unless-stopped"

  # Set the stop timeout (in seconds)
  #stop_timeout = 120
}