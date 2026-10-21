# A third provider-free stage: applied by the merge itself (apply-on-merge).
variable "buckets" {
  type    = number
  default = 3
}

resource "terraform_data" "buckets" {
  input = var.buckets
}
