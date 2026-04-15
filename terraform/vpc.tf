resource "aws_vpc" "terralearn_vpc" {
  cidr_block = var.vpc_cdir
  region     = var.region

  tags = {
    Name = "terralearn_vpc"
  }
}
