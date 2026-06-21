
output "ls_framework_ecs_task_definition_arn" {
  value = aws_ecs_task_definition.ls_framework_ecs_task_definition.arn
}
output "ls_framework_log_group_name" {
  value = aws_cloudwatch_log_group.ls_framework_logs.name
  description = "The name of the specific LS Framework microservices api"
}

output "ls_framework_ecs_task_execution_role_arn" {
  value = aws_iam_role.ls_framework_ecs_task_execution_role.arn
}
output "ls_framework_ecs_task_role_arn" {
  value = aws_iam_role.ls_framework_ecs_task_role.arn
}


# output "ls_framework_lb_listner_production_arn" {
#   value = one(aws_lb_listener.ls_framework_lb_listner_production[*].arn)
# }
# output "ls_framework_lb_listner_test_arn" {
#   value = one(aws_lb_listener.ls_framework_lb_listner_test[*].arn)
# }
