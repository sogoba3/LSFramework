# resource "aws_route53_record" "ls_framework_route53_record_backend" {
#   # count = var.is_web_service ? 1 : 0
#     zone_id = var.ls_framework_route53_zone_id
#     name = "${var.gateway_subdomain}.${var.domain_name}"
#     type = "A"

#     alias {
#       zone_id = var.ls_framework_alb_zone_id
#       name = var.ls_framework_alb_dns_name
#       evaluate_target_health = true
#     }
# }