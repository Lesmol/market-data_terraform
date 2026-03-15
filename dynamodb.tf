resource "aws_dynamodb_table" "app_config" {
  name         = "AppConfigTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
