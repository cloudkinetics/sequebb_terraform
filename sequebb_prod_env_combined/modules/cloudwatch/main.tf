# resource "aws_cloudwatch_log_group" "log_group" {
#   count = length(var.cloudwatch_log_group_name)
#   name = var.cloudwatch_log_group_name[count.index]

#   tags = {
#     Environment = var.Environment
#   }
# }


# resource "aws_cloudwatch_log_group" "yada" {
#   name = "Yada"

#   tags = {
#     Environment = "production"
#     Application = "serviceA"
#   }
# }

