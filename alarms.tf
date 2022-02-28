#Alarms
resource "aws_cloudwatch_metric_alarm" "monitor_api_4xx" {
  alarm_name                = "4xxError"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "4XXError"
  namespace                 = "AWS/ApiGateway"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors API"
  insufficient_data_actions = []
  dimensions = {
    ApiName = "myapi"
    Stage = "live"
  }
}

resource "aws_cloudwatch_metric_alarm" "monitor_api_5xx" {
  alarm_name                = "5xxError"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "5XXError"
  namespace                 = "AWS/ApiGateway"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors API"
  insufficient_data_actions = []
  dimensions = {
    ApiName = "myapi"
    Stage = "live"
  }
}