# GCP side — verified/listed by api/cloud_gcp.go (Compute + GCS).
resource "google_compute_instance" "api" {
  name         = "terrasuite-api"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
  }

  labels = {
    owner = "platform"
    tier  = "api"
  }
}

resource "google_storage_bucket" "exports" {
  name                        = "terrasuite-exports-demo"
  location                    = "US"
  uniform_bucket_level_access = true

  labels = {
    owner = "platform"
    tier  = "exports"
  }
}
