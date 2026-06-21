# resource "aws_alb" "ls_framework_internal_alb" {
#   name               = "${var.project_prefix}-internal-alb"
#   internal           = true
#   load_balancer_type = "application"

#   security_groups = [aws_security_group.ls_framework_internal_alb_sg.id]
#   subnets         = var.ls_framework_private_subnets
  
#   enable_deletion_protection = false

#   access_logs {
#     bucket  = var.ls_framework_alb_logs
#     enabled = true
#   }


#   tags = {
#     Name = "${var.project_prefix}-internal-alb"
#   }
# }

# ### LS FRAMEWORK APPLICATION LOAD BALANCER FACING THE DOWNSTREAM SERVICES (HIDDEN PRIVATELY)

# resource "aws_security_group" "ls_framework_internal_alb_sg" {
#   name   = "${var.project_prefix}-internal-alb-sg"
#   vpc_id = var.ls_framework_vpc_id
#   description = "LS Framework ALB Security Group allowing gatway-api traffic to the downstream services"

#   tags = {
#     Name = "${var.project_prefix}-internal-alb-sg"
#   }
# }


# resource "aws_vpc_security_group_ingress_rule" "ls_framework_int_ingress_rule_http" {
#   security_group_id            = aws_security_group.ls_framework_internal_alb_sg.id
#   referenced_security_group_id = var.ls_framework_ecs_service_sg_id
#   from_port                    = 80
#   ip_protocol                  = "tcp"
#   to_port                      = 80

#   description = "Allow HTTP"
# }


# resource "aws_vpc_security_group_ingress_rule" "ls_framework_int_ingress_rule_https" {
#   security_group_id            = aws_security_group.ls_framework_internal_alb_sg.id
#   referenced_security_group_id = var.ls_framework_ecs_service_sg_id
#   #module.ls_framework_gateway.ls_framework_ecs_service_sg_id
#   from_port                    = 8080
#   ip_protocol                  = "tcp"
#   to_port                      = 8080

#   description = "Allow HTTPs"
# }

# # Outbound traffic
# resource "aws_vpc_security_group_egress_rule" "ls_framework_int_egress_rule" {
#   security_group_id = aws_security_group.ls_framework_internal_alb_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
# }