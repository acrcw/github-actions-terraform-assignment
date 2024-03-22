module "lambda" {
  source                         = "./lambdamodule"
  lamba_function_name            = "tf-lambda"
  bucket_id_for_s3               = module.s3.bucket_id
  cloudwatch_logging_policy_name = "CloudWatch-logging-policy"
  iam_role_name_lambda           = "role_for_lambda"
}
module "s3" {
  source      = "./s3module"
  bucket_name = "group4-lamba-s3-bucket"
  tags = {
    "Name" : "s3-for-github-trigger",
    "Environment" : "dev"
  }

}

module "dynamodb" {
  source         = "./dynamodb"
  lambda_role_id = module.lambda.iam_for_lambda_id
  table_name     = "lamda_s3_info_logging_table"
  tabletags = {
    Name        = "lamda_s3_info_logging_table"
    Environment = "production"
  }
  table_partion_key              = "id"
  role_name_for_dynamo_db_access = "lambda-dynamodb-access"

}