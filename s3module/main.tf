resource "aws_s3_bucket" "s3_for_trigger" {
  bucket = "group4-lamba-s3-bucket"
  tags = var.tags
}