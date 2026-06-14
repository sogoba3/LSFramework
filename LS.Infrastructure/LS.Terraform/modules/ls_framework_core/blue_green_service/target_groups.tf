### Blue Target Group
resource "aws_lb_target_group" "ls_framework_lb_blue_tg" {
    # count = var.is_gateway_service ? 1 : 0
    name = "${var.service_name}-blue-tg"
    port = var.container_port
    protocol = "HTTP"

    target_type = "ip"
    vpc_id = var.ls_framework_vpc_id

    
    health_check {
      enabled = true
      path = var.health_check_path
      protocol = "HTTP"
      matcher = "200"

      interval = 30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 3
    }

    tags = {
      Name = "${var.project_prefix}-${var.service_name}-blue-tg"
    }
}

### Green Target Group
resource "aws_lb_target_group" "ls_framework_lb_green_tg" {
  # count = var.is_gateway_service ? 1 : 0
  name        = "${var.service_name}-green-tg" #downstream services
  port        = var.container_port #8080
  protocol    = "HTTP"

  target_type = "ip"
  vpc_id = var.ls_framework_vpc_id

  health_check {
      enabled = true
      path = var.health_check_path
      protocol = "HTTP"
      matcher = "200"

      interval = 30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 3
    }

    tags = {
      Name = "${var.project_prefix}-${var.service_name}-green-tg"
    }
}