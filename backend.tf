terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-project1-jenkins1"
    key    = "terraform.tfstate"
    region = "ap-southeast-2"

  }
}