# terraform {
#   backend "s3" {
#     bucket = "group-4-bucket"
#     key    = "terraform.tfstate"
#     region = "ap-south-1"
#     dynamodb_table="state-locking-table"
#   }
# }