# Multi-cloud sample estate

Declarations for the three `cloudProvider` implementations in TerraSuite:

| File | Provider | Resource types the live side lists |
|---|---|---|
| `aws.tf` | AWS | `aws_instance`, `aws_s3_bucket` |
| `gcp.tf` | GCP | `google_compute_instance`, `google_storage_bucket` |
| `azure.tf` | Azure | `azurerm_virtual_machine`, `azurerm_storage_account` |

All values are literals so the static scanner (`terrascan hcl`) can synthesise
a plan without provider credentials. No state backend is configured — this
is a declaration fixture, not something to apply.

The GCP/Azure live sides read the providers' REST APIs. In local testing those
APIs are emulated by local stubs (floci itself only emulates AWS).
