
# # Create CloudWatch Metric Filter to extract relevant metrics from logs
# resource "aws_cloudwatch_metric_filter" "metric_filter" {
#   count = length(var.metric_filter_name)
#   name           = var.metric_filter_name[count.index]
#   pattern        = var.pattern[count.index]
#   log_group_name = var.log_group_name[count.index]

#   metric_transformation {
#     name      = var.metric_transformation_name[count.index]
#     namespace = var.metric_transformation_namespace[count.index]
#     value     = var.metric_transformation_value[count.index]
#   }
# }

# resource "aws_cloudwatch_log_metric_filter" "yada" {
#   name           = "MyAppAccessCount"
#   pattern        = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup) }"
#   log_group_name = aws_cloudwatch_log_group.dada.name

#   metric_transformation {
#     name      = "EventCount"
#     namespace = "YourNamespace"
#     value     = "1"
#   }
# }