resource "aws_dynamodb_table" "dynamodb-table" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = var.table_partion_key #partition key

  attribute {
    name = var.table_partion_key
    type = "S"
  }

  tags = var.tabletags
}

resource "aws_iam_role_policy" "lambda-dynamodb-access" {
   name = var.role_name_for_dynamo_db_access
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