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
   backend "local" {
    path = "/container_shared/tfstate/aws.tfstate"
  }

  # This project started with the state stored in the provider's oject storage.  
  # I moved it to local storage as providers charge for object storage and there was no benefit once the exercise was complete.
  # backend "gcs" {
  #   bucket  = "asiwko-gcp-terraform-state-bucket" # Name of your GCS bucket
  #   prefix  = "terraform/state"                   # Path inside the bucket
  # }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "linode" {
  token = var.LINODE_API_KEY
}