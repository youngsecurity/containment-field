# This boilerplate includes the basic components of a Terraform configuration:
# 1. The provider block specifies which cloud provider to use (aws) and sets the region to us-east-1.
# 2. The variable block defines any input variables that the Terraform configuration needs. In this case, we've defined aws_access_key and aws_secret_key, but their values will be set outside of this configuration file (e.g. via environment variables or command-line arguments).
# 3. The resource block defines the infrastructure resources that Terraform will manage. In this example, we've defined an AWS EC2 instance using the aws_instance resource type.
# 4. The output block defines any output values that Terraform should display after the infrastructure is provisioned. In this case, we're outputting the public IP address of the EC2 instance.
# Once you have created your Terraform configuration file (e.g. main.tf), you can run terraform init to initialize the Terraform environment, terraform plan to see what changes Terraform will make, and terraform apply to apply those changes and provision the infrastructure.

# Define provider
provider "aws" {
  region = "us-east-1"
}

# Define variables
variable "aws_access_key" {}
variable "aws_secret_key" {}

# Define resources
#resource "aws_instance" "example" {
#  ami           = "ami-0c55b159cbfafe1f0"
#  instance_type = "t2.micro"
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

  # Mount the external volumes
  # Mount /tmp/.X11-unix from the host to the container
  #mounts {
  #  target = "/tmp/.X11-unix"
  #  source = "/tmp/.X11-unix"
  #  type   = "bind"
  #}

  # Encrypt the root block device
#  ebs_block_device {
#    device_name = "/dev/sda1"
#    encrypted   = true
#  }

  # Set the stop timeout (in seconds)
  #stop_timeout = 120

  # Add capabilities
  #capabilities {
  #  add = ["NET_ADMIN"]
  #}
    
# Define outputs
output "public_ip" {
  value = aws_instance.example.public_ip
}
