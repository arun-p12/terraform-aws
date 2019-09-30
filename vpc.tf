# Create a VPC
resource "aws_vpc" "xx-vpc" {
  # e.g. VPC_CIDR["poc"] + "/" + BLOCKSIZE  -->  192.168.0.0/16
  cidr_block = "${var.VPC_CIDR[terraform.workspace]}/${var.VPC_BLOCKSIZE}"

  # e.g. TENANCY["poc"] --> default
  instance_tenancy = var.TENANCY[terraform.workspace]

  tags = {
    Entity    = "vpc"
    Lifecycle = terraform.workspace
    Name      = var.PROJECT
    Project   = var.PROJECT
  }
}
