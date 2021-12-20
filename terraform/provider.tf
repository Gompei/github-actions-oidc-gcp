terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.4.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "~> 4.4.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = "asia-northeast1"
  credentials = file(var.credentials_path)
}

provider "google-beta" {
  project     = var.project_id
  region      = "asia-northeast1"
  credentials = file(var.credentials_path)
}
