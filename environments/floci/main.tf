# floci stage — a live AWS (floci emulator) target for the customer journey.
# Every resource here is real: the plan creates it, the apply creates it in
# the cloud, and a later drift check sees it changed out of band.
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "app" {
  bucket = "terrasuite-test-terraform-floci"
  tags = {
    Environment = "floci"
    Owner      = "platform-team"
  }
}

resource "aws_sqs_queue" "work" {
  name                      = "terrasuite-test-terraform-floci-queue"
  visibility_timeout_seconds = 30
  tags = {
    Environment = "floci"
  }
}
