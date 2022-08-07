terraform {
  backend "s3" {
    bucket  = "devops-2022-2-terraform-tfstate"
    key     = "day3/terraform.tfstate"
    region  = "us-east-1"
    profile = "dev"
  }
}