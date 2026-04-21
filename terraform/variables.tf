variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "vpc_cdir" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_public_subnet" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_private_subnet" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "vpc_subnets_availability_zone" {
  type    = list(string)
  default = ["eu-north-1a", "eu-north-1b"]
}

variable "ecr_image" {
  type    = string
  default = "803283181124.dkr.ecr.eu-north-1.amazonaws.com/kamil-repository:latest"
}