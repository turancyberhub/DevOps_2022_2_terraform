provider "aws" {
  region  = "us-east-1"
  profile = "dev"
}

provider "aws" {
  region  = "us-east-2"
  profile = "dev"
  alias = "ohio"
}

provider "aws" {
  region  = "us-west-1"
  profile = "dev"
  alias = "california"
}

provider "aws" {
  region  = "us-west-2"
  profile = "dev"
  alias = "oregon"
}