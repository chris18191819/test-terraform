# Root config: terragraph's webhook plan runs at the repository root, so the
# repository needs a plannable configuration there (stage paths in
# terrasuite.yaml are only read by the static scanner).
#
# The aws provider plans offline (mock/skip flags — a test fixture, never for
# apply): the root plan must carry priceable cloud resources for the cost
# estimate, the per-resource cost table and the budget gate.
terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region                      = "ap-south-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock"
  secret_key                  = "mock"
}

variable "dev_node_desired_size" {
  type    = number
  default = 3
}

resource "terraform_data" "dev_node_group" {
  input = var.dev_node_desired_size
}

# Two priced instances so the plan comment shows cost per resource, not just
# a total.
resource "aws_instance" "e2e_probe" {
  ami           = "ami-0c55b159cbfa81f4a"
  instance_type = "t3.medium"
  tags = {
    Name    = "terracloud-e2e-probe"
    Env     = "default"
    Project = "terracloud-e2e"
  }
}

resource "aws_instance" "e2e_worker" {
  ami           = "ami-0c55b159cbfa81f4a"
  instance_type = "t3.small"
  tags = {
    Name    = "terracloud-e2e-worker"
    Env     = "default"
    Project = "terracloud-e2e"
  }
}

# Deliberate policy finding for the first plan: SEC-003 requires
# encrypted = true. The next commit flips it and the comment goes green.
resource "aws_ebs_volume" "e2e_data" {
  availability_zone = "ap-south-1a"
  size              = 20
  type              = "gp3"
  encrypted         = true
  tags = {
    Name    = "terracloud-e2e-data"
    Env     = "default"
    Project = "terracloud-e2e"
  }
}
