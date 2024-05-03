#creating efs 
resource "aws_efs_file_system" "efs" {
  creation_token = var.creation_token
  encrypted      = var.efs_encryption
  kms_key_id     = aws_kms_key.kms_key.arn
  tags = {
    Name        = var.efs_name
    Environment = var.Environment
  }
}
##creating kms key
resource "aws_kms_key" "kms_key" {
  description = var.kms_description

  tags = {
    Name = var.efs_kms_key
  }

}