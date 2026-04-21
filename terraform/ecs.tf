# Defining cluster and task definition

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "terralearn-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "terralearn-containers"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "${var.ecr_image}"
      essential = true
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_log_group.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "terralearn-nginx"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = "nginx"
    container_port   = 80
  }

  network_configuration {
    assign_public_ip = false
    subnets          = aws_subnet.vpc_private_subnet[*].id
    security_groups  = [aws_security_group.ecs_sg.id]
  }
}