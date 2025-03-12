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
  #host = ${DOCKER_HOST}
  #ca_material   = ${CA_MATERIAL}
  #cert_material = ${CERT_MATERIAL}
  #key_material  = ${KEY_MATERIAL}
}

# Pull the Docker image
resource "docker_image" "traefik:v3.3.4" {
  name = "treafik:v3.3.4"
}

# Reference the existing external volume(s)
resource "docker_volume" "tfk-01" {
  name = "tfk-01"

  lifecycle {
    prevent_destroy = true
  }
}

resource "docker_volume" "tfk-01" {
  name = "tfk-01"

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
resource "docker_container" "tfk-01" {
  image = docker_image.tfk-01.image_id
  name  = "tfk-01"
  hostname = "tfk-01"
  tty = true

  # Set environment variables
  env = [
    "TZ=America/New_York",
  ]

  # Mount the external volume
  mounts {
    target = "/app/backend/data"
    source = resource.docker_volume.tfk-01.name
    type   = "volume"
  }

  # Connect to the external network with a static IP
  networks_advanced {
    name         = data.docker_network.macvlan255.name
    ipv4_address = "10.0.255.8"
  }

}