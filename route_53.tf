# module "zones" {
#   # Create a hosted zone for the website.
#   source  = "terraform-aws-modules/route53/aws//modules/zones"
#   version = "~> 2.0"

#   zones = {
#     (var.r53_zone_name) = {
#       comment = (var.r53_zone_name)
#     }
#   }

#   tags = {
#     ManagedBy = "Terraform"
#   }
# }

# module "records" {
#   # Create an A record for the DNS entry for the website
#   # and point that to the cloudfront distribution. 
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"
#   depends_on = [
#     module.cloudfront
#   ]
#   zone_id = lookup(module.zones.route53_zone_zone_id, "s3_example.co.uk")
#   records = [
#     {
#       name = ""
#       type = "A"
#       alias = {
#         name    = module.cloudfront.cloudfront_distribution_domain_name
#         zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
#       }
#     },
#   ]

# }