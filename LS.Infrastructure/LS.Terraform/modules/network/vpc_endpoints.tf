
### S3 GATEWAY ENDPOINT
resource "aws_vpc_endpoint" "ls_framework_s3_gateway_vpce" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    service_name = "com.amazonaws.${var.aws_region}.s3"

    vpc_endpoint_type = "Gateway"

    route_table_ids = [aws_route_table.ls_framework_private_route_table_a.id, aws_route_table.ls_framework_private_route_table_b.id, aws_route_table.ls_framework_private_route_table_c.id, aws_route_table.ls_framework_db_private_route_table.id]

    tags = {
    Name = "${var.project_prefix}-s3-gateway-vpce"
    }
}

### INTERFACE ENDPOINT FOR LS FRAMEWORK ECR
resource "aws_vpc_endpoint" "ls_framework_ecr_vpce" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    service_name = "com.amazonaws.${var.aws_region}.ecr.api"

    vpc_endpoint_type = "Interface"

    subnet_ids = [
    aws_subnet.ls_framework_private_subnet_a.id,
    aws_subnet.ls_framework_private_subnet_b.id,
    aws_subnet.ls_framework_private_subnet_c.id
    ]

    security_group_ids = [aws_security_group.ls_framework_vpc_endpoint_sg.id]

    private_dns_enabled = true

    tags = {
      Name = "${var.project_prefix}-ecr-api"
    }
}

### INTERFACE ENDPOINT FOR ECR DOCKER
resource "aws_vpc_endpoint" "ls_framework_ecr_dkr_vpce" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"

    vpc_endpoint_type = "Interface"

    subnet_ids = [
    aws_subnet.ls_framework_private_subnet_a.id,
    aws_subnet.ls_framework_private_subnet_b.id,
    aws_subnet.ls_framework_private_subnet_c.id
    ]

    security_group_ids = [aws_security_group.ls_framework_vpc_endpoint_sg.id]

    private_dns_enabled = true

    tags = {
      Name = "${var.project_prefix}-ecr-dkr"
    }
}

### INTERFACE ENDPOINT FOR CLOUDWATCH LOGS
resource "aws_vpc_endpoint" "ls_framework_cloudwatch_logs_vpce" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    service_name = "com.amazonaws.${var.aws_region}.logs"

    vpc_endpoint_type = "Interface"

    subnet_ids = [
    aws_subnet.ls_framework_private_subnet_a.id,
    aws_subnet.ls_framework_private_subnet_b.id,
    aws_subnet.ls_framework_private_subnet_c.id
    ]

    security_group_ids = [aws_security_group.ls_framework_vpc_endpoint_sg.id]

    private_dns_enabled = true

    tags = {
      Name = "${var.project_prefix}-logs"
    }
}

### INTERFACE ENDPOINT FOR SECRETS MANAGER
resource "aws_vpc_endpoint" "ls_framework_secrets_manager_vpce" {
    vpc_id = aws_vpc.ls_framework_vpc.id
    service_name = "com.amazonaws.${var.aws_region}.secretsmanager"

    vpc_endpoint_type = "Interface"

    subnet_ids = [
    aws_subnet.ls_framework_private_subnet_a.id,
    aws_subnet.ls_framework_private_subnet_b.id,
    aws_subnet.ls_framework_private_subnet_c.id,

    #  aws_subnet.ls_framework_private_db_subnet_a.id,
    #  aws_subnet.ls_framework_private_db_subnet_b.id,
    #  aws_subnet.ls_framework_private_db_subnet_c.id
    ]

    security_group_ids = [aws_security_group.ls_framework_vpc_endpoint_sg.id]

    private_dns_enabled = true

    tags = {
      Name = "${var.project_prefix}-secretsmanager"
    }
}

