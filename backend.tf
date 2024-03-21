terraform {
  backend "s3" {
    bucket         = "bucket-for-backend-tf" # bucket for backend on s3
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "state-locking-table" #state loclking table must be partitioned by LockID
  }
}