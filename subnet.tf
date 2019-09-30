# get the list of all AZ in the region
data "aws_availability_zones" "all" {}

# Public facing subnet. Ensure entities have public IPs
resource "aws_subnet" "xx-subnet-dmz" {
  count             = length(data.aws_availability_zones.all.names)
  availability_zone = data.aws_availability_zones.all.names[count.index]
  vpc_id            = aws_vpc.xx-vpc.id

  # 192.168 current hard-coded. Needs to be extracted from VPC cidr_block
  cidr_block              = "192.168.${count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Entity    = "subnet"
    Lifecycle = terraform.workspace
    Name      = "${var.PROJECT}-dmz-${count.index}"
    Project   = var.PROJECT
  }
}

# Private subnet. Ensure entities DO NOT have public IPs
resource "aws_subnet" "xx-subnet-web" {
  count             = length(data.aws_availability_zones.all.names)
  availability_zone = data.aws_availability_zones.all.names[count.index]
  vpc_id            = aws_vpc.xx-vpc.id

  cidr_block              = "192.168.${50+count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Entity    = "subnet"
    Lifecycle = terraform.workspace
    Name      = "${var.PROJECT}-web-${count.index}"
    Project   = var.PROJECT
  }
}

# Private subnet. Ensure entities DO NOT have public IPs
resource "aws_subnet" "xx-subnet-app" {
  count             = length(data.aws_availability_zones.all.names)
  availability_zone = data.aws_availability_zones.all.names[count.index]
  vpc_id            = aws_vpc.xx-vpc.id

  cidr_block              = "192.168.${100+count.index}.0/24"
  map_public_ip_on_launch = false

  tags = {
    Entity    = "subnet"
    Lifecycle = terraform.workspace
    Name      = "${var.PROJECT}-app-${count.index}"
    Project   = var.PROJECT
  }
}
