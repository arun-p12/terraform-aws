# client supplied region of deployment
variable "AWS_REGION" {}

# a unique name ; used for tagging
variable "PROJECT" {}

# CIDR mask for the subnet
variable "SUBNET_BLOCKSIZE" {
  default = "24"
}

# IPv4 addressable block range. Subnet carved from it
variable "SUBNET_CIDR" {
  type = "map"
  default = {
    "poc" = {
      "dmz" = "192.168.0.0"
      "web" = "192.168.1.0"
      "app" = "192.168.2.0"
    }
    "dev" = {
      "dmz" = "192.168.0.0"
      "web" = "192.168.1.0"
      "app" = "192.168.2.0"
    }
    "stg" = {
      "dmz" = "172.16.0.0"
      "web" = "172.16.1.0"
      "app" = "172.16.2.0"
    }
    "prd" = {
      "dmz" = "10.0.0.0"
      "web" = "10.0.1.0"
      "app" = "10.0.2.0"
    }
  }
}

# should servers in subnet get public IPs?
variable "SUBNET_PUBLIC_IP" {
  type = "map"
  default = {
    "dmz" = true
    "web" = false
    "app" = false
  }
}

# security zones into which the VPC is subdivided
variable "SUBNET_ZONES" {
  default = ["dmz", "web", "app"]
}

# inbound connectivity
variable "SECURITY_GROUP" {
  type    = "map"
  default = {
    "dmz" = {
      "ports"      = [22, 80]
      "protocol"   = "tcp"
      "cidr_block" = ["0.0.0.0/0"]
    }
    "web" = {
      "ports"      = [22, 80, 443]
      "protocol"   = "tcp"
      "cidr_block" = ["0.0.0.0/0"]
    }
  }
}

# default (i.e. shared) vs dedicsated hosts
variable "TENANCY" {
  type = "map"
  default = {
    "poc" = "default"
    "dev" = "default"
    "stg" = "dedicated"
    "prd" = "dedicated"
  }
}

# largest block size is 16 (ie. 16 - 28)
variable "VPC_BLOCKSIZE" {
  default = "16"
}

# IPv4 addressable block range. Subnet carved from it
variable "VPC_CIDR" {
  type = "map"
  default = {
    "poc" = "192.168.0.0"
    "dev" = "192.168.0.0"
    "stg" = "172.16.0.0"
    "prd" = "10.0.0.0"
  }
}
