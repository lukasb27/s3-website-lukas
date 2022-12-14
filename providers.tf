terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

# Configure the AWS Provider
# Save credentials as s3Demo in ~/.aws/credential
provider "aws" {
  region  = "eu-west-2"
  profile = "s3_website_example"
}

provider "aws" {
  alias   = "aws_us-east-1"
  region  = "us-east-1"
  profile = "s3_website_example"
}