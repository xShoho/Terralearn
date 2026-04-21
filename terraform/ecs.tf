resource "aws_ecs_cluster" "ecs_cluster" {
  name = "terralearn-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}