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
#
## provider "google" {
##  credentials = file("/workspace/terraform-deployer.json")
##  project     = var.project_id
##  region      = var.region
##}
##
##resource "google_storage_bucket" "IAM-STORAGE-BUCKET" {
##  name     = "example-bucket-${random_id.bucket_id.hex}"
##  location = var.region
##
##  uniform_bucket_level_access = true
##}
##
##resource "random_id" "bucket_id" {
##  byte_length = 4
##}
##
##terraform {
##  backend "gcs" {
##    bucket = "IAM-STORAGE-BUCKET"
##    prefix = "terraform/state"
##  }
##}
#

# Provider Configuration
provider "google" {
  credentials = file("gcp-terraform-keys.json")   # Use the service account credentials
  project     = var.project_id
  region      = var.region
}

# Create a GCS Bucket for Logs
resource "google_storage_bucket" "log_bucket" {
  name          = "${var.bucket_name}"
  location      = var.region
  storage_class = "STANDARD"

  # Bucket settings
  force_destroy = true  # Automatically delete the bucket with terraform destroy

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      storage_class,       # Ignore changes to storage class
      labels               # Ignore label updates
    ]
  }

}

resource "google_compute_instance" "vm_ware" {
  name         = "example-vm-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      machine_type,    # Ignore changes to machine type
      metadata         # Ignore metadata updates
    ]
  }
}


# IAM Permissions for Cloud Build Service Account
resource "google_storage_bucket_iam_member" "cloudbuild_writer" {
  bucket = google_storage_bucket.log_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.cloudbuild_sa}"
}


resource "google_bigquery_dataset" "medical_company" {
  dataset_id = "medical_company"  # Name of the dataset
  description = "A dataset for storing my data"
  location    = "US"
}