# This boilerplate includes the basic components of a Terraform configuration:
# 1. The provider block specifies which cloud provider to use (aws) and sets the region to us-east-1.
# 2. The variable block defines any input variables that the Terraform configuration needs. In this case, we've defined aws_access_key and aws_secret_key, but their values will be set outside of this configuration file (e.g. via environment variables or command-line arguments).
# 3. The resource block defines the infrastructure resources that Terraform will manage. In this example, we've defined an AWS EC2 instance using the aws_instance resource type.
# 4. The output block defines any output values that Terraform should display after the infrastructure is provisioned. In this case, we're outputting the public IP address of the EC2 instance.
# Once you have created your Terraform configuration file (e.g. main.tf), you can run terraform init to initialize the Terraform environment, terraform plan to see what changes Terraform will make, and terraform apply to apply those changes and provision the infrastructure.

# Define provider
terraform {  
  required_providers {

#    aws = {
#      region = "us-east-1"
#    }
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
resource "docker_image" "IMAGENAME" {
  name = "IMAGENAME"
}

# Reference the existing external volume
resource "docker_volume" "VOLUMENAME" {
  name = "VOLUMENAME"
  
  lifecycle {
    prevent_destroy = true
  }
}

# Reference the existing external network
resource "docker_network" "NETWORKNAME" {
  name = "NETWORKNAME"
  driver = "macvlan"

  lifecycle {
    prevent_destroy = true
  }
}

data "docker_network" "NETWORKNAME" {
  name = "NETWORKNAME"  
}

# Create the Docker container
resource "docker_container" "CONTAINERNAME" {  
  image = docker_image.CONTAINERNAME.image_id
  name  = "NAME"
  hostname = "HOSTNAME"  
  gpus = "device=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c"
  tty = true

  # Set environment variables
  env = [
    "TZ=America/New_York",
  ]

  # Add capabilities
  #capabilities {
  #  add = ["NET_ADMIN"]
  #}
  
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

  # Set the stop timeout (in seconds)
  #stop_timeout = 120

  # Mount the external volume
  mounts {
    target = "/path/in/container"
    source = resource.docker_volume.VOLUMENAME.name
    type   = "volume"
  }

  # Mount the external volumes
  # Mount /tmp/.X11-unix from the host to the container
  #mounts {
  #  target = "/tmp/.X11-unix"
  #  source = "/tmp/.X11-unix"
  #  type   = "bind"
  #}

  # Connect to the external network with a static IP
  networks_advanced {
    name         = data.docker_network.NETWORKNAME.name
    ipv4_address = "IP"
  }

  # Set the restart policy
  restart = "unless-stopped"
}
# Define variables
#variable "aws_access_key" {}
#variable "aws_secret_key" {}

#resource "aws_instance" "example" {
#  ami           = "ami-0c55b159cbfafe1f0"
#  instance_type = "t2.micro"
#}

  # Encrypt the root block device
#  ebs_block_device {
#    device_name = "/dev/sda1"
#    encrypted   = true
#  }

# Define outputs
#output "public_ip" {
#  value = aws_instance.example.public_ip
#}
