

# module "acm" {
#   # Create a TLS/SSL cert for viewing the website over HTTPS.

#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 3.0"
#   providers = {
#     aws = aws.aws_us-east-1
#   }

#   domain_name = var.r53_zone_name
#   zone_id     = lookup(module.zones.route53_zone_zone_id, var.r53_zone_name)
# }

# module "cloudfront" {
#   # Present the s3 bucket via a CDN - AWS cloudfront. 

#   source  = "terraform-aws-modules/cloudfront/aws"
#   version = "2.9.2"
#   aliases = [var.r53_zone_name]

#   comment             = var.r53_zone_name
#   enabled             = true
#   is_ipv6_enabled     = true
#   price_class         = "PriceClass_100"
#   retain_on_delete    = false
#   wait_for_deployment = false

#   # When you enable additional metrics for a distribution, CloudFront sends up to 8 metrics to CloudWatch in the US East (N. Virginia) Region.
#   # This rate is charged only once per month, per metric (up to 8 metrics per distribution).
#   create_monitoring_subscription = false

#   create_origin_access_identity = false
#   default_root_object = var.root_html_path
#   origin = {
#     # https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_Origin.html
#     s3_example = {
#       domain_name = "${var.bucket_name}.s3.eu-west-2.amazonaws.com"
#       origin_id   = "s3_exampleS3Origin"
#       custom_origin_config = {
#         http_port              = 80
#         https_port             = 443
#         origin_protocol_policy = "match-viewer"
#         origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
#       }

#       custom_header = [
#         {
#           name  = "X-Forwarded-Scheme"
#           value = "https"
#         },
#         {
#           name  = "X-Frame-Options"
#           value = "SAMEORIGIN"
#         }
#       ]
#     }

#     s3_one = {
#       domain_name = "${var.bucket_name}.s3.eu-west-2.amazonaws.com"
#     }
#   }
#   default_cache_behavior = {
#     target_origin_id       = "s3_exampleS3Origin"
#     viewer_protocol_policy = "redirect-to-https"

#     allowed_methods = ["GET", "HEAD", "OPTIONS"]
#     cached_methods  = ["GET", "HEAD"]
#     compress        = true
#     query_string    = true
#   }
#   origin_group = {
#     s3_exampleS3OriginGroup = {
#       failover_status_codes      = [403, 404, 500, 502]
#       primary_member_origin_id   = "s3_exampleS3Origin"
#       secondary_member_origin_id = "s3_one"
#     }
#   }

#   # Use the created TLS Cert
#   viewer_certificate = {
#     acm_certificate_arn = module.acm.acm_certificate_arn
#     ssl_support_method  = "sni-only"
#   }
# }
