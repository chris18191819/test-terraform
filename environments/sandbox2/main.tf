# A second provider-free stage: this one is applied by the merge itself
# (apply-on-merge), not by a hand-queued apply.
variable "replicas" {
  type    = number
  default = 2
}

resource "terraform_data" "replicas" {
  input = var.replicas
}
