resource "aws_s3_bucket" "s3_for_trigger" {
  bucket = var.bucket_name
  tags = var.tags
}