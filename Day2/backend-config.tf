terraform {
  backend "s3" {
    bucket  = "devops-2022-2-terraform-tfstate"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "dev"
  }
}