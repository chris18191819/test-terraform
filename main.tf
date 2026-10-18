# Root config: terragraph's webhook plan runs at the repository root, so the
# repository needs a plannable configuration there (stage paths in
# terrasuite.yaml are only read by the static scanner).
#
# The aws provider plans offline (mock/skip flags — a test fixture, never for
# apply): the root plan must carry a priceable cloud resource for the cost
# estimate and budget gate to have a real number to work with.
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

resource "aws_instance" "e2e_probe" {
  ami           = "ami-0c55b159cbfa81f4a"
  instance_type = "t3.medium"
  tags = {
    Name = "terracloud-e2e-probe"
    Env  = "default"
  }
}
