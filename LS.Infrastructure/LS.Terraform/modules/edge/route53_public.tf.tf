

### ROUTE53 HOSTED ZONE
resource "aws_route53_zone" "ls_framework_route53_zone" {
    count = var.enable_dns ? 1 : 0
    name = "lsframework.com"
}

### WWW DNS RECORD
# resource "aws_route53_record" "ls_framework_route53_record_frontend" {
#     zone_id = aws_route53_zone.ls_framework_route53_zone.id
#     name = "www.lsframework.com"
#     type = "A"

#     alias {
#       zone_id = aws_cloudfront_distribution.ls_framework_frontend_s3_distribution.hosted_zone_id
#       name = aws_cloudfront_distribution.ls_framework_frontend_s3_distribution.domain_name
#       evaluate_target_health = false
#     }
# }

# resource "aws_route53_record" "frontend_cert_validation" {
#   for_each = var.enable_acm ? {
#     for dvo in aws_acm_certificate.ls_framework_frontend_cert[0].domain_validation_options :
#     dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   } : {}

#   allow_overwrite = true

#   zone_id = aws_route53_zone.ls_framework_route53_zone.id

#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.record]
#   # lifecycle {
#   #   create_before_destroy = true
#   # }
# }

# resource "aws_acm_certificate_validation" "frontend_cert_validation" {
#   count = var.enable_acm ? 1 : 0
#   provider = aws.virginia

#   certificate_arn = aws_acm_certificate.ls_framework_frontend_cert[0].arn

#   validation_record_fqdns = [
#     for record in aws_route53_record.frontend_cert_validation :
#     record.fqdn
#   ]
# }
