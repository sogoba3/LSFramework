### http listner
### Production Traffic
resource "aws_lb_listener" "ls_framework_lb_listner_production" {
    load_balancer_arn = aws_alb.ls_framework_external_alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = var.gateway_blue_target_group_arn
      # type = "fixed-response"
      # fixed_response {
      #   content_type = "text/plain"
      #   message_body = "No matching route"
      #   status_code  = "404"
      # }
    }
}

### Test listener
### CodeDeploy Green
resource "aws_lb_listener" "ls_framework_lb_listner_test" {
  load_balancer_arn = aws_alb.ls_framework_external_alb.arn

  port     = 8443
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = var.gateway_green_target_group_arn
    # type = "fixed-response"
    # fixed_response {
    #   content_type = "text/plain"
    #   message_body = "No matching route"
    #   status_code  = "404"
    # }
  }
}