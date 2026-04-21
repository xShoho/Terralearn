resource "aws_lb" "lb" {
  name               = "terralearn-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for subnet in aws_subnet.vpc_public_subnet : subnet.id]

  enable_deletion_protection = false
}