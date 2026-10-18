# Root config: terragraph's webhook plan runs at the repository root, so the
# repository needs a plannable configuration there (stage paths in
# terrasuite.yaml are only read by the static scanner).
variable "dev_node_desired_size" {
  type    = number
  default = 3
}

resource "terraform_data" "dev_node_group" {
  input = var.dev_node_desired_size
}
