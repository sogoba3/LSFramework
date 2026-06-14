output "ls_framework_frontend_s3_distribution_arn" {
  value = aws_cloudfront_distribution.ls_framework_frontend_s3_distribution.arn
}
output "ls_framework_cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.ls_framework_frontend_s3_distribution.id
}

# output "ls_framework_backend_cert_arn" {
#   value = aws_acm_certificate.ls_framework_backend_cert.arn
# }
# output "ls_framework_frontend_cert_arn" {
#   value = aws_acm_certificate.ls_framework_frontend_cert[0].arn
# }

# output "ls_framework_route53_zone_id" {
#   value = aws_route53_zone.ls_framework_route53_zone.id
# }