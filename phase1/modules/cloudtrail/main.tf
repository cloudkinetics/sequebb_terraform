## creating Cloudtrail
resource "aws_cloudtrail" "Cloud_trail" {
  name                          = var.cloud_trail_name
  s3_bucket_name                = aws_s3_bucket.log.id
  s3_key_prefix                 = var.s3_key_prefix
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.cloud_trail_multiregion
}
#Bucket for cloudtrail logs
resource "aws_s3_bucket" "log" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
}
#Data for bucket policy
data "aws_iam_policy_document" "cloudtrail_policy" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.log.arn]
  }
  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.log.arn}/prefix/AWSLogs/000025338164/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
#Creating bucket policy
resource "aws_s3_bucket_policy" "policy_bucket" {
  bucket = aws_s3_bucket.log.id
  policy = data.aws_iam_policy_document.cloudtrail_policy.json
}