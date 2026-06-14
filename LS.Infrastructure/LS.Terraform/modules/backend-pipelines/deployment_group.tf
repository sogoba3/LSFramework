
# resource "aws_codedeploy_deployment_group" "ls_framework_deployment_group" {
#   count = var.deployment_type == "BLUE_GREEN" ? 1 : 0
#   app_name               = aws_codedeploy_app.ls_framework_codedeploy_ecs[0].name
#   deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
#   deployment_group_name  = "${var.service_name}-deployment-group"
#   service_role_arn       = aws_iam_role.ls_framework_codedeploy_ecs_role.arn

#   auto_rollback_configuration {
#     enabled = true
#     events  = ["DEPLOYMENT_FAILURE"]
#   }

#   blue_green_deployment_config {
#     deployment_ready_option {
#       action_on_timeout = "CONTINUE_DEPLOYMENT"
#     }

#     terminate_blue_instances_on_deployment_success {
#       action                           = "TERMINATE"
#       termination_wait_time_in_minutes = 5
#     }
#   }

#   deployment_style {
#     deployment_option = "WITH_TRAFFIC_CONTROL"
#     deployment_type   = "BLUE_GREEN"
#   }

#   ecs_service {
#     cluster_name = var.ls_framework_ecs_cluster_name
#     service_name = var.ls_framework_ecs_service_name
#   }

#   dynamic "load_balancer_info" {
#     for_each = var.is_web_service ? [1] : []
#     content {
#       target_group_pair_info {
#         prod_traffic_route {
#           listener_arns = [var.ls_framework_lb_listner_production_arn]
#         }

#         test_traffic_route {
#           listener_arns = [ var.ls_framework_lb_listner_test_arn ]
#         }

#         target_group {
#           name = var.ls_framework_lb_blue_tg_name
#         }

#         target_group {
#           name = var.ls_framework_lb_green_tg_name
#         }
#       }
#     }
#   }
# }