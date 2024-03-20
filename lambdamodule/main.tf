data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Define the IAM policy that allows lambda to create log streams and put log events
resource "aws_iam_policy" "cloudwatch_log_policy" {
  name   = "function-logging-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Attach the policy to the IAM role created in step 1, by creating new resource 'aws_iam_role_policy_attachment'
resource "aws_iam_role_policy_attachment" "cloudwatch_log_policy" {
  role       = aws_iam_role.iam_for_lambda.id
  policy_arn = aws_iam_policy.cloudwatch_log_policy.arn
}


# Define the IAM role for lambda:
resource "aws_iam_role" "iam_for_lambda" {
  name               = "role_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# Define the log group
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lamba_function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_lambda_function" "lambda_aws" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/../lambdacode/lambda_function_payload.zip"
  function_name = var.lamba_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  depends_on    = [aws_cloudwatch_log_group.lambda_log_group]
  source_code_hash = data.archive_file.zipped_code.output_base64sha256

  runtime = "python3.12"

}

# to create a archive of the code to upload to lambda
data "archive_file" "zipped_code" {
  type        = "zip"
  source_file = "${path.module}/../lambdacode/lambda_function.py"
  output_path = "${path.module}/../lambdacode/lambda_function_payload.zip"
}