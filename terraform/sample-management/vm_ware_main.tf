## IAM Permissions for Cloud Build Service Account
#resource "google_storage_bucket_iam_member" "cloudbuild_writer" {
#  bucket = google_storage_bucket.log_bucket.name
#  role   = "roles/storage.objectAdmin"
#  member = "serviceAccount:${var.cloudbuild_sa}"
#}
##
##
##resource "google_bigquery_dataset" "medical_company" {
##  dataset_id = "medical_company"  # Name of the dataset
##  description = "A dataset for storing my data"
##  location    = "US"
##}