# Role for ecs containers

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "terralearn-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

# Policy

resource "aws_iam_policy" "ecs_task_execution_role_policy" {
  name = "terralearn-ecs-task-execution-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      # Pull images from ecr
      Effect = "Allow"
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ]
      Resource = "*"
      }, {
      Effect = "Allow"
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["${aws_cloudwatch_log_group.ecs_log_group.arn}:*"]
    }]
  })
}