variable "lambda_role_id" {
    type=string  
}
variable "table_name" {
    type=string 
}
variable "table_partion_key" {
    type=string 
}
variable "role_name_for_dynamo_db_access" {
    type=string 
}
variable "tabletags" {
    type=map(any) 
}