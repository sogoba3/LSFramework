# #Production Listener Rule
# resource "aws_lb_listener_rule" "ls_framework_gateway_blue" {
#   listener_arn = aws_lb_listener.ls_framework_lb_listner_production.arn
#   priority = 100
#   action {
#     type = "forward"
#     target_group_arn = var.gateway_blue_target_group_arn
#   }
#   condition {
#     host_header {
#       values = [ "api.${var.domain_name}" ]
#     }
#   }
# }

# resource "aws_lb_listener_rule" "ls_framework_gateway_green" {
#   listener_arn = aws_lb_listener.ls_framework_lb_listner_test.arn
#   priority = 100
#   action {
#     type = "forward"
#     target_group_arn = var.gateway_green_target_group_arn
#   }
#   condition {
#     host_header {
#       values = [ "api.${var.domain_name}" ]
#     }
#   }
# }

