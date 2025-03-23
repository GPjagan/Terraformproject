# # GCP Provider
# provider "google" {
#   project     = "upheld-castle-452119-c2"
#   region      = "us-central1"
#   credentials = file("/workspace/terraform-deployer.json")
# }
#
# # VM Instance
# resource "google_compute_instance" "my_instance" {
#   name         = "cloudbuild-vm"
#   machine_type = "e2-medium"
#   zone         = "us-central1-a"
#
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }
#
#   network_interface {
#     network = "default"
#     access_config {}
#   }
#
#   tags = ["cloudbuild", "ci-cd"]
# }

 provider "google" {
  credentials = file("/workspace/terraform-deployer.json")
  project     = var.project_id
  region      = var.region
}

resource "google_storage_bucket" "IAM-STORAGE-BUCKET" {
  name     = "example-bucket-${random_id.bucket_id.hex}"
  location = var.region

  uniform_bucket_level_access = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

terraform {
  backend "gcs" {
    bucket = "IAM-STORAGE-BUCKET"
    prefix = "terraform/state"
  }
}

