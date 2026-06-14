terraform {
  required_version = "~> 1.15.5"

  backend "s3" {
    bucket = "lsf-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-2"
    #dynamodb_table = "terraform-locks"

    encrypt = true

    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}
# provider "aws" {
#   alias = "virginia"
#   region = "us-east-1"
# }

# terraform {
#   # required_providers {
#   #   aws = {
#   #     source = "hashicorp/aws"
#   #     version = "~> 3.0"

#   #   }
#   # }
#   backend "s3" {
#     bucket = "value"
#     key = "value"
#     region = "value"
#     dynamodb_table = "value"
#     encrypt = true
#   }
# }