module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr


  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets

  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"


    public_subnet_tags = "jenkins-subnet"
  }
}
#SG
module "security_group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 5.0"
  name        = "jenkins-sg"
  description = "Security group for Jenkins server"
  vpc_id      = module.vpc.default_vpc_id


  ingress_rules       = ["ssh-tcp", "http-80-tcp", "https-443-tcp", ]
  ingress_cidr_blocks = ["10.0.0.0/16"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Environment = "dev"
    Name        = "jenkins-sg"
  }
}