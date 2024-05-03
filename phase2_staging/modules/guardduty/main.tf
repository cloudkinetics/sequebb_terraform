resource "aws_guardduty_detector" "guardduty" {
  enable = var.enable_guardduty

  tags = {
    Environment = var.Environment
  }
}