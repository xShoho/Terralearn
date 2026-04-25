# Creating CloudWatch logs group

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/terralearn"
  retention_in_days = 7
}