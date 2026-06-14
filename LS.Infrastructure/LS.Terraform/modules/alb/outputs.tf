output "ls_framework_alb_dns_name" {
  value = aws_alb.ls_framework_external_alb.dns_name
}
output "ls_framework_alb_zone_id" {
  value = aws_alb.ls_framework_external_alb.zone_id
}
output "ls_framework_lb_listner_production_arn" {
  value = aws_lb_listener.ls_framework_lb_listner_production.arn
}
output "ls_framework_lb_listner_test_arn" {
  value = aws_lb_listener.ls_framework_lb_listner_test.arn
}
output "ls_framework_external_alb_sg_id" {
  value = aws_security_group.ls_framework_external_alb_sg.id
}
