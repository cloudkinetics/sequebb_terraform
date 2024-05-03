# resource "aws_config_configuration_recorder" "config" {
#   name     = var.config_name
#   role_arn = var.config_role_arn

#   recording_group {
#     all_supported = var.all_supported
#     include_global_resource_types = var.include_global_resource_types
#   }
# }

# resource "aws_config_delivery_channel" "config_deliver_channel" {
#   name           = var.config_channel_name
#   s3_bucket_name = var.config_s3_bucket_name
#   s3_key_prefix = "config"
#   s3_kms_key_arn = var.kms_key
# }

# resource "aws_config_configuration_recorder_status" "config_recorder_status" {
#   name       = aws_config_configuration_recorder.config.name
#   is_enabled = var.recorder_enable
#   depends_on = [aws_config_delivery_channel.config_deliver_channel]
# }
