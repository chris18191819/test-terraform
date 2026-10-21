# A stage with no cloud provider: the plan for it needs no credential, so
# the lifecycle can be exercised end to end without an AWS account.
terraform {
  required_version = ">= 1.5"
}

variable "node_count" {
  type    = number
  default = 1
}

resource "terraform_data" "node_group" {
  input = var.node_count
}

output "node_count" {
  value = terraform_data.node_group.output
}
