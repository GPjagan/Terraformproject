# GCP Provider
provider "google" {
  project     = "<YOUR_PROJECT_ID>"
  region      = "us-central1"
  credentials = file("${path.module}/Terraform-secret.json")
}

# VM Instance
resource "google_compute_instance" "my_instance" {
  name         = "cloudbuild-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["cloudbuild", "ci-cd"]
}
