# floci stage — a live AWS (floci emulator) target for the customer journey.
# Every resource here is real: the plan creates it, the apply creates it in
# the cloud, and a later drift check sees it changed out of band.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # pinned: the apply re-plans and compares digests
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # The endpoint is an S3-compatible service on a custom host, so the
  # provider must use path-style addressing (virtual-host addressing would
  # ask DNS for "<bucket>.<host>", which does not resolve).
  s3_use_path_style = true
}

resource "aws_s3_bucket" "app" {
  bucket = "terrasuite-test-terraform-floci"
  tags = {
    Environment = "floci"
    Owner      = "platform-team"
  }
}

resource "aws_sqs_queue" "work" {
  name                       = "terrasuite-test-terraform-floci-queue"
  visibility_timeout_seconds = 30
  tags = {
    Environment = "floci"
  }
}

# Priced against the catalog (AmazonEC2 / us-east-1), so the budget gate
# has a real number to compare instead of an unpriced plan.
resource "aws_instance" "worker" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  tags = {
    Name        = "terrasuite-floci-worker"
    Environment = "floci"
  }
}
