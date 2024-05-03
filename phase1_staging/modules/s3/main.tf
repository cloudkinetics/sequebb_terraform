#creating s3
resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name
  #acl    = var.acl_s3

  tags = {
    Environment = var.Environment
  }
}
resource "aws_s3_bucket_ownership_controls" "b" {
  bucket = aws_s3_bucket.b.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}