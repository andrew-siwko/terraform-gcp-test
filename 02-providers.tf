terraform {
  required_providers {
    # We will be working with GCP and so will need the google provider
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }    # in order to update DNS on linode, we'll need the linode provider.
    linode = {
      source  = "linode/linode"
    }
  }
  # We want to store the Terraform state file in gcp using a GCS bucket.
  backend "gcs" {
    bucket  = "asiwko-gcp-terraform-state-bucket" # Name of your GCS bucket
    prefix  = "terraform/state"                   # Path inside the bucket
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "linode" {
  token = var.LINODE_API_KEY
}