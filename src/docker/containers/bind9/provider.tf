terraform {
  
  required_providers {
    dns = {
        source = "hashicorp/dns"
        version = "3.4.2"
    }
  }
}

variable "tsig_key" {
  type = string
  sensitive = true  
}

# Configure the DNS Provider
provider "dns" {
  update {
    server        = "10.0.255.24"
    key_name      = "tsig-key."
    key_algorithm = "hmac-sha256"
    key_secret    = var.tsig_key
  }
}