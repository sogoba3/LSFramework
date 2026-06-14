
data "aws_availability_zones" "available" {
  state = "available"
}

# Start of LSFramework Public Subnets
resource "aws_subnet" "ls_framework_public_subnet_a" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    cidr_block = var.public_subnet_cidrs[0]
    availability_zone = data.aws_availability_zones.available.names[0]

    #This will automatically assign a public ipv4 to any ressources launched into this subnet.
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_prefix}-public-subnet-a"
    }
}

resource "aws_subnet" "ls_framework_public_subnet_b" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    cidr_block = var.public_subnet_cidrs[1]
    availability_zone = data.aws_availability_zones.available.names[1]

    #This will automatically assign a public ipv4 to any ressources launched into this subnet.
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_prefix}-public-subnet-b"
    }
}

resource "aws_subnet" "ls_framework_public_subnet_c" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    cidr_block = var.public_subnet_cidrs[2]
    availability_zone = data.aws_availability_zones.available.names[2]

    #This will automatically assign a public ipv4 to any ressources launched into this subnet.
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_prefix}-public-subnet-c"
    }
}
# End of LSFramework Public Subnets

###############################################################################################

# Start of LSFramework private Subnets
resource "aws_subnet" "ls_framework_private_subnet_a" {
  vpc_id = aws_vpc.ls_framework_vpc.id
  cidr_block = var.private_subnet_cidrs[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_prefix}-private-subnet-a"
  }
}

resource "aws_subnet" "ls_framework_private_subnet_b" {
  vpc_id = aws_vpc.ls_framework_vpc.id
  cidr_block = var.private_subnet_cidrs[1]
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project_prefix}-private-subnet-b"
  }
}

resource "aws_subnet" "ls_framework_private_subnet_c" {
  vpc_id = aws_vpc.ls_framework_vpc.id
  cidr_block = var.private_subnet_cidrs[2]
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "${var.project_prefix}-private-subnet-c"
  }
}
# End of LSFramework private Subnets

###############################################################################################

# Start of LSFramework private DB Subnets
resource "aws_subnet" "ls_framework_private_db_subnet_a" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    cidr_block = var.private_db_subnet_cidrs[0]
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        Name = "${var.project_prefix}-private-db-subnet-a"
    }
}

resource "aws_subnet" "ls_framework_private_db_subnet_b" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    cidr_block = var.private_db_subnet_cidrs[1]
    availability_zone = data.aws_availability_zones.available.names[1]

    tags = {
        Name = "${var.project_prefix}-private-db-subnet-b"
    }
}

resource "aws_subnet" "ls_framework_private_db_subnet_c" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    cidr_block = var.private_db_subnet_cidrs[2]
    availability_zone = data.aws_availability_zones.available.names[2]

    tags = {
        Name = "${var.project_prefix}-private-db-subnet-c"
    }
}
# End of LSFramework private DB Subnets
