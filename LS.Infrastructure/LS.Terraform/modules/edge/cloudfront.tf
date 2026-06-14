
### cloudfront origin access control (AOC)
resource "aws_cloudfront_origin_access_control" "ls_framework_aoc_frontend" {
    name = "${var.project_prefix}-aoc-frontend"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
}


### cloudfront distribution
resource "aws_cloudfront_distribution" "ls_framework_frontend_s3_distribution" {
    ### S3 ORIGIN
    origin {
      domain_name = var.ls_framework_frontend_bucket_regional_domain_name
      origin_access_control_id = aws_cloudfront_origin_access_control.ls_framework_aoc_frontend.id
      origin_id = "LSFrameworkS3Origin"
    }
    enabled = true
    default_root_object = "index.html"

    #remove it for dev
    # aliases = [ "www.lsframework.com" ]
    aliases = var.enable_cloudfront_custom_domain ? ["www.lsframework.com"] : []

    ### DEFAULT CACHE BEHAVIOR
    default_cache_behavior {
      # "OPTIONS", "PATCH", "POST", "PUT" "DELETE", 
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "LSFrameworkS3Origin"#local.s3_origin_id

        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
        compress = true
    }

    ### REACT SPA ROUTING
    custom_error_response {
        error_code = 404
        response_code = 200
        response_page_path = "/index.html"
    }

    ### PRICE CLASS CHEAPEST OPTION
    price_class = "PriceClass_100"
    
    ### GEO RESTRICTIONS
    restrictions {
      geo_restriction {
        restriction_type = "none"
      }
    }

    ### SSL CERTIFICATE
    viewer_certificate {
      cloudfront_default_certificate = true
    }
    # viewer_certificate {
    #   acm_certificate_arn = aws_acm_certificate.ls_framework_frontend_cert[0].arn
    #   ssl_support_method = "sni-only"
    #   minimum_protocol_version = "TLSv1.2_2021"
    # }

    tags = {
      Name = "${var.project_prefix}-frontend-s3-distribution"
    }

}