resource "aws_cloudwatch_event_rule" "bi_weekly_market_check" {
  name                = "bi-weekly-market-data-trigger"
  description         = "Triggers the market data collector bi-weekly"
  schedule_expression = "cron(0 7 ? * TUE,THU *)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.bi_weekly_market_check.name
  target_id = "market_data_function"
  arn       = aws_lambda_function.market_data_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.market_data_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.bi_weekly_market_check.arn
}