
# Start of PUBLIC ROUTE TABLE
resource "aws_route_table" "ls_framework_public_route_table" {
    vpc_id = aws_vpc.ls_framework_vpc.id

    tags = {
      Name = "${var.project_prefix}-public-route-table"
    }
}

resource "aws_route" "ls_framework_public_route" {
    route_table_id = aws_route_table.ls_framework_public_route_table.id
    destination_cidr_block = var.destination_cidr_block
    gateway_id = aws_internet_gateway.ls_framework_igw.id
}
# End of PUBLIC ROUTE TABLE

# Start of PUBLIC SUBNETS ASSOCIATIONS
resource "aws_route_table_association" "ls_framework_public_association_a" {
    subnet_id = aws_subnet.ls_framework_public_subnet_a.id
    route_table_id = aws_route_table.ls_framework_public_route_table.id
}

resource "aws_route_table_association" "ls_framework_public_association_b" {
    subnet_id = aws_subnet.ls_framework_public_subnet_b.id
    route_table_id = aws_route_table.ls_framework_public_route_table.id
}

resource "aws_route_table_association" "ls_framework_public_association_c" {
    subnet_id = aws_subnet.ls_framework_public_subnet_c.id
    route_table_id = aws_route_table.ls_framework_public_route_table.id
}
# End of PUBLIC SUBNETS ASSOCIATIONS

###############################################################################################

# Start of PRIVATE ROUTE TABLE
resource "aws_route_table" "ls_framework_private_route_table_a" {
    vpc_id = aws_vpc.ls_framework_vpc.id

    tags = {
      Name = "${var.project_prefix}-private-route-table-a"
    }
}

resource "aws_route" "ls_framework_private_route_a" {
    route_table_id = aws_route_table.ls_framework_private_route_table_a.id
    destination_cidr_block = "0.0.0.0/0" #var.destination_cidr_block
    nat_gateway_id = aws_nat_gateway.ls_framework_nat_a.id
}

resource "aws_route_table" "ls_framework_private_route_table_b" {
    vpc_id = aws_vpc.ls_framework_vpc.id

    tags = {
      Name = "${var.project_prefix}-private-route-table-b"
    }
}

resource "aws_route" "ls_framework_private_route_b" {
    route_table_id = aws_route_table.ls_framework_private_route_table_b.id
    destination_cidr_block = "0.0.0.0/0" #var.destination_cidr_block
    nat_gateway_id = aws_nat_gateway.ls_framework_nat_b.id
}

resource "aws_route_table" "ls_framework_private_route_table_c" {
    vpc_id = aws_vpc.ls_framework_vpc.id

    tags = {
      Name = "${var.project_prefix}-private-route-table-c"
    }
}

resource "aws_route" "ls_framework_private_route_c" {
    route_table_id = aws_route_table.ls_framework_private_route_table_c.id
    destination_cidr_block = "0.0.0.0/0" #var.destination_cidr_block
    nat_gateway_id = aws_nat_gateway.ls_framework_nat_c.id
}

# End of PRIVATE ROUTE TABLE

# Start of private SUBNETS ASSOCIATIONS
resource "aws_route_table_association" "ls_framework_private_association_a" {
    subnet_id = aws_subnet.ls_framework_private_subnet_a.id
    route_table_id = aws_route_table.ls_framework_private_route_table_a.id
}

resource "aws_route_table_association" "ls_framework_private_association_b" {
    subnet_id = aws_subnet.ls_framework_private_subnet_b.id
    route_table_id = aws_route_table.ls_framework_private_route_table_b.id
}

resource "aws_route_table_association" "ls_framework_private_association_c" {
    subnet_id = aws_subnet.ls_framework_private_subnet_c.id
    route_table_id = aws_route_table.ls_framework_private_route_table_c.id
}
# End of private SUBNETS ASSOCIATIONS

###############################################################################################

# Start of DB SUBNET GROUP FOR RDS SQL SERVER
resource "aws_db_subnet_group" "ls_framework_sqlserver_db_subnet_group" {
    name = "${var.project_prefix}-db-subnet-group"
    subnet_ids = [
        aws_subnet.ls_framework_private_db_subnet_a.id,
        aws_subnet.ls_framework_private_db_subnet_b.id,
        aws_subnet.ls_framework_private_db_subnet_c.id
    ]

    tags = {
      Name = "${var.project_prefix}-db-subnet-group"
    }
}

resource "aws_route_table" "ls_framework_db_private_route_table" {
    vpc_id = aws_vpc.ls_framework_vpc.id

    tags = {
      Name = "${var.project_prefix}-db-private-rt"
    }
}

# End of DB SUBNET GROUP FOR RDS SQL SERVER

# Start of private DB SUBNETS ASSOCIATIONS
resource "aws_route_table_association" "ls_framework_private_db_association_a" {
  subnet_id      = aws_subnet.ls_framework_private_db_subnet_a.id
  route_table_id = aws_route_table.ls_framework_db_private_route_table.id
}

resource "aws_route_table_association" "ls_framework_private_db_association_b" {
  subnet_id      = aws_subnet.ls_framework_private_db_subnet_b.id
  route_table_id = aws_route_table.ls_framework_db_private_route_table.id
}

resource "aws_route_table_association" "ls_framework_private_db_association_c" {
  subnet_id      = aws_subnet.ls_framework_private_db_subnet_c.id
  route_table_id = aws_route_table.ls_framework_db_private_route_table.id
}
# End of private DB SUBNETS ASSOCIATIONS
