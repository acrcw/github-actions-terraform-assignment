module "lambda"{
    source = "./lambdamodule"
    lamba_function_name="tf-lambda"
    bucket_id_for_s3=module.s3.bucket_id

}
module "s3" {
    source="./s3module" 
    tags = {
      "Name" : "s3-for-github-trigger",
      "Environment":"dev" 
    }

}