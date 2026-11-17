# Multi-cloud sample estate used by TerraSuite's flag-gated cloud providers.
# Literal-only on purpose: terrascan's hcl mode synthesises a plan from
# literals, so every attribute here is visible to the scanner without a
# variable file or a live provider call.
#
# The shapes match what each cloudProvider implementation lists:
#   AWS   aws_instance / aws_s3_bucket          (floci-emulatable)
#   GCP   google_compute_instance / google_storage_bucket
#   Azure azurerm_virtual_machine / azurerm_storage_account

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "google" {
  project = "terrasuite-demo"
  region  = "us-central1"
}

provider "azurerm" {
  features {}
  subscription_id = "00000000-0000-0000-0000-000000000001"
}
