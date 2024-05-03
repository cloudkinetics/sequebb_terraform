resource "aws_efs_file_system" "efs" {
  creation_token = var.creation_token
}


# resource "aws_transfer_server" "sftp_server" {
#   identity_provider_type = var.identity_provider_type
#   endpoint_type           = var.endpoint_type

#   tags = {
#     Environment = var.environment
#   }
# }



# # Create IAM role for SFTP users with access to Amazon EFS filesystem
# resource "aws_iam_role" "sftp_user_role" {
#   name               = var.sftp_rolename
#   assume_role_policy = jsonencode({
#     Version   = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = {
#         Service = "transfer.amazonaws.com"
#       },
#       Action    = "sts:AssumeRole"
#     }]
#   })
# }
# resource "aws_efs_file_system_policy" "efs_policy" {
#   file_system_id = aws_efs_file_system.efs.id

# policy = jsonencode({
#   Version   = "2012-10-17"
#   Statement = [
#     {
#       Effect    = "Allow"
#       Principal = {
#         AWS = aws_iam_role.sftp_user_role.arn
#       }
#       Action    = [
#         "elasticfilesystem:ClientMount",
#         "elasticfilesystem:ClientWrite",
#         "elasticfilesystem:ClientRootAccess",
#       ]
#       Resource  = "*"
#     }
#   ]
# })

# }


# # Associate IAM role with SFTP server
# resource "aws_transfer_user" "sftp_server_user" {
#   server_id = aws_transfer_server.sftp_server.id
#   user_name = var.sftp_user_name
#   role      = aws_iam_role.sftp_user_role.arn
# }

# resource "aws_efs_mount_target" "mount" {
#   file_system_id = aws_efs_file_system.efs.id
#   subnet_id      = var.subnet_id
# }