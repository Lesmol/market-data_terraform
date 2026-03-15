resource "aws_iam_role" "lambda_exec" {
  name = "market_data_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["dynamodb:GetItem"]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.app_config.arn
      },
      {
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "market_data_function" {
  function_name = "market-data-function"
  package_type = "Image"
  image_uri    = "${aws_ecr_repository.market_data.repository_url}:latest"
  role          = aws_iam_role.lambda_exec.arn
  memory_size = 512
  timeout       = 300

  environment {
    variables = {
      POLYGON_API_KEY       = var.polygon_api_key
      EMAIL_SERVICE_API_KEY = var.email_service_api_key
      EMAIL_API_URL         = var.hosted_email_api_url
      CONFIG_TABLE          = aws_dynamodb_table.app_config.name
    }
  }
}
