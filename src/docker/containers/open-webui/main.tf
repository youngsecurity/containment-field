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
  name = "ghcr.io/open-webui/open-webui:0.5.20"
}

# Reference the existing external volume
resource "docker_volume" "open-webui" {
  name = "open-webui"
  
  lifecycle {
    prevent_destroy = true
  }
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
  hostname = "open-webui"  
  gpus = "device=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c"
  tty = true
  labels {    
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label="traefik.http.routers.open-webui.rule"
    value="Host(`open-webui.home.youngsecurity.net`)"
  }
  labels {
    label="traefik.http.routers.open-webui.entrypoints"
    value="websecure"
  }
  labels {
    label="traefik.http.routers.open-webui.tls"
    value="true"
  }
  labels {
    label="traefik.http.routers.open-webui.tls.certresolver"
    value="cloudflare"
  }
  labels {
    label="traefik.http.services.open-webui.loadbalancer.server.port"
    value="8080"
  }

  # Set environment variables
  env = [
    "TZ=America/New_York",
    "OLLAMA_BASE_URL=http://ollama:11434",
  ]

  # Mount the external volume
  mounts {
    target = "/app/backend/data"
    source = resource.docker_volume.open-webui.name
    type   = "volume"
  }

  # Connect to the external network with a static IP
  networks_advanced {
    name         = data.docker_network.macvlan255.name
    ipv4_address = "10.0.255.148"
  }

  # Set the restart policy
  restart = "unless-stopped"
}