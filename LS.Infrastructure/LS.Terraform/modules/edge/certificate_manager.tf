
### Public Frontend Certificate
# resource "aws_acm_certificate" "ls_framework_frontend_cert" {
#     count = var.enable_acm ? 1 : 0
#     provider = aws.virginia

#     domain_name = var.ls_framework_domain_name #"lsframework.com"
#     subject_alternative_names = [ "*.lsframework.com" ]
#     validation_method = "DNS"
    
#     lifecycle {
#       create_before_destroy = true
#     }

#     tags = {
#       Name = "${var.project_prefix}-acm-certification"
#     }
# }

### Backend Api's Certificate
# resource "aws_acm_certificate" "ls_framework_backend_cert" {
#     domain_name = var.ls_framework_domain_name # "lsframework.com"
#     subject_alternative_names = [ "*.lsframework.com" ]
#     validation_method = "DNS"
#     lifecycle {
#       create_before_destroy = true
#     }

#     tags = {
#       Name = "${var.project_prefix}-acm-certification"
#     }
# }