terraform {
  required_version = ">= 1.10.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "my-reception-memories"
    key    = "ecs-01/simpletimeservice/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true # here I am using latest state locking feature of Terraform
  }
}

provider "aws" {
  region = "us-east-1"
}
