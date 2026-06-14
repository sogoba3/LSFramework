output "ls_framework_ecs_task_execution_role_arn" {
  value = aws_iam_role.ls_framework_ecs_task_execution_role.arn
}
output "ls_framework_ecs_task_role_arn" {
  value = aws_iam_role.ls_framework_ecs_task_role.arn
}

output "ls_framework_worker_sg_id" {
  value = aws_security_group.worker_sg.id
}