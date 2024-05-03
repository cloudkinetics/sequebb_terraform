resource "aws_kms_key" "kms" {
  description             = var.kms_description
  deletion_window_in_days = var.kms_deletion_window_in_days
  multi_region = var.kms_multi_region

  tags = {
    Environment = var.Environment
  }
}