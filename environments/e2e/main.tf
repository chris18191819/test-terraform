# Provider-free stage used by the browser E2E cycle: plan → gate → approve → apply.
# terraform_data needs no cloud credentials, so the sandboxed runner can
# plan and apply it against a fresh checkout.
variable "replicas" {
  type    = number
  default = 3
}

resource "terraform_data" "e2e_marker" {
  input = {
    name     = "terrasuite-e2e"
    replicas = var.replicas
  }
}
