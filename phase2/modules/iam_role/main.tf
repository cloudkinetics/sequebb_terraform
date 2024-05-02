resource "aws_iam_role" "config_role" {
  name               = var.config_role_name
  assume_role_policy = data.aws_iam_policy_document.config_assume_role.json

  tags = {
    Environment = var.Environment
  }
}
resource "aws_iam_policy" "config_policy" {
  name        = aws_iam_role.config_role.name
  description = "Policy for AWS Config"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "config:*",
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "config_attachment" {
  role       = aws_iam_role.config_role.name
  policy_arn = aws_iam_policy.config_policy.arn
}

