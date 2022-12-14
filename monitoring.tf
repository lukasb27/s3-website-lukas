# module "cloudfront_errors" {
#     # Create an alarm based on 500 errors in cloudfront.
#     depends_on = [module.cloudfront]
#     source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
#     version = "4.0.0"


#     alarm_name    = "Cloudfront Error"
#     comparison_operator = "GreaterThanOrEqualToThreshold"
#     evaluation_periods = 3
#     alarm_description = "Trigger an alarm based on 500 error"
#     namespace = "AWS/Cloudfront"
#     metric_name = "5xxErrorRate"
#     statistic           = "Average"
#     period = "120"
#     threshold = "1"
# }