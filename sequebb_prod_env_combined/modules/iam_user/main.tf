resource "aws_iam_user" "user" {
  name = var.user_name
  
  tags = {
    Environment = var.Environment
  }
}



resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.user.name
  policy_arn = var.policy_arn


}