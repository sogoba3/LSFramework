output "ls_framework_ecs_service_name" {
  value = aws_ecs_service.ls_framework_ecs_service_name.name
  description = "The name of the service running LS Framework microservices containers"
}
output "ls_framework_lb_blue_tg_arn" {
  value = aws_lb_target_group.ls_framework_lb_blue_tg.arn
}
output "ls_framework_lb_green_tg_arn" {
  value = aws_lb_target_group.ls_framework_lb_green_tg.arn
}
output "ls_framework_lb_blue_tg_name" {
  value = aws_lb_target_group.ls_framework_lb_blue_tg.name
}
output "ls_framework_lb_green_tg_name" {
  value = aws_lb_target_group.ls_framework_lb_green_tg.name
}