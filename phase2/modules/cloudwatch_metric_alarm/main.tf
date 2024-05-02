
# # # Create CloudWatch Alarm to monitor the metric
# # resource "aws_cloudwatch_metric_alarm" "metric_alarm" {
# #   count = length(var.alarm_name)
# #   alarm_name          = var.alarm_name[count.index]
# #   comparison_operator = var.comparison_operator[count.index]
# #   evaluation_periods  = var.evaluation_periods[count.index]
# #   metric_name         = var.metric_name[count.index]
# #   namespace           = var.namespace[count.index]
# #   period              = var.period[count.index]
# #   statistic           = var.statistic[count.index]
# #   threshold           = var.threshold[count.index]
# #   alarm_description   = var.alarm_description[count.index]

# #   tags = {
# #     Environment = var.Environment
# #   }
# # }

# resource "aws_cloudwatch_metric_alarm" "foobar" {
#   alarm_name                = "SecurityGroup"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = 2
#   metric_name               = "CPUUtilization"
#   namespace                 = "AWS/EC2"
#   period                    = 300
#   statistic                 = "Sum"
#   threshold                 = 1
#   alarm_description         = "This metric monitors ec2 cpu utilization"
#   insufficient_data_actions = []
# }