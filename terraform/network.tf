# Use the Default VPC (Free & Easy for Demos)
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Get Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create Default Subnets
resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}