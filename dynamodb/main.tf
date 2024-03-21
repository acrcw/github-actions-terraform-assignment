resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "lamda_s3_info_logging_table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id" #partition key

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "lamda_s3_info_logging_table"
    Environment = "production"
  }
}

resource "aws_iam_role_policy" "lambda-dynamodb-access" {
   name = "lambda-dynamodb-access"
   role = var.lambda_role_id
   policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:GetItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                
            ],
            "Resource": "${aws_dynamodb_table.dynamodb-table.arn}"
        }
    ]
})
}