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
resource "docker_image" "pihole" {
  name = "pihole/pihole:2024.07.0"
}

# Reference the existing external volume
resource "docker_volume" "pihole_etc" {
  name = "pihole_etc"

  lifecycle {
    prevent_destroy = true
  }
}
resource "docker_volume" "pihole_etc_dnsmasq_d" {
  name = "pihole_etc_dnsmasq.d"

  lifecycle {
    prevent_destroy = true
  }
}

data "docker_network" "macvlan255" {
  name = "macvlan255"
}

# Create the Docker container
resource "docker_container" "pihole" {
  image = docker_image.pihole.image_id
  name  = "pihole"
  hostname = "pihole"
  tty = true
  labels {
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label="traefik.http.routers.pihole.rule"
    value="Host(`pihole.home.youngsecurity.net`) || Host(`pihole.youngsecurity.net`)"
  }
  labels {
    label="traefik.http.routers.pihole.entrypoints"
    value="websecure"
  }
  labels {
    label="traefik.http.routers.pihole.tls"
    value="true"
  }
  labels {
    label="traefik.http.routers.pihole.tls.certresolver"
    value="cloudflare"
  }
  labels {
    label="traefik.http.services.pihole.loadbalancer.server.port"
    value="80"
  }

  # Set environment variables
  env = [
    "TZ=America/New_York",
    "VIRTUAL_HOST=pihole"
  ]

  # Mount the external volume
  mounts {
    target = "/etc/pihole"
    source = resource.docker_volume.pihole_etc.name
    type   = "volume"
  }
  mounts {
    target = "/etc/dnsmasq.d"
    source = resource.docker_volume.pihole_etc_dnsmasq_d.name
    type   = "volume"
  }
  # Connect to the external network with a static IP
  networks_advanced {
    name         = data.docker_network.macvlan255.name
    ipv4_address = "10.0.255.155"
  }

  # Set the restart policy
  restart = "unless-stopped"
}