output "data_block_output" {
    value = data.aws_iam_policy_document.assume_role 
}

output "iam_for_lambda_id" {
    value=aws_iam_role.iam_role_for_lambda.id
}