variable "project_prefix" {type = string}
variable "ls_framework_vpc_id" {
  type = string
}
variable "ls_framework_ecs_service_sg_id" {
  type = string
}
variable "ls_framework_private_subnets" {
  type = list(string)
}
variable "ls_framework_public_subnets" {
  type = list(string)
}
variable "ls_framework_alb_logs" {
  type = string
}
variable "routing_port" {
  type = string
}
variable "routing_test_port" {
  type = string
}
# variable "ls_framework_acm_certificate_arn" {
#   type = string
# }
# variable "service_name" {
#   type = string
# }
# variable "service_target_groups" {
#   type = map(object({
#     blue  = string
#     green = string
#   }))
# }
variable "gateway_blue_target_group_arn" {
  type = string
}
variable "gateway_green_target_group_arn" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "is_web_service" {
  type = bool
  default = true
}
