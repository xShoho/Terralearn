# ECR API endpoint

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.vpc_private_subnet[*].id
  security_group_ids = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true
}

# ECR Docker endpoint

resource "aws_vpc_endpoint" "ecr_docker" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.vpc_private_subnet[*].id
  security_group_ids = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true
}

# S3 gateway endopoint

resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = aws_route_table.private[*].id
}

# Cloudwatch logs endpoint

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = aws_vpc.vpc.id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.vpc_private_subnet[*].id
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  private_dns_enabled = true
}