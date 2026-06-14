
##########
# VPC
##########
resource "aws_vpc" "ls_framework_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "${var.project_prefix}-vpc"
    }

    lifecycle {
      create_before_destroy = true
    }
}


