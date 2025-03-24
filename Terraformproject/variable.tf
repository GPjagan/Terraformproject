#variable "project_id" {
#  description = "The ID of the GCP project"
#  type        = string
#  default     = "upheld-castle-452119-c2"
#}
#
#variable "region" {
#  description = "GCP region"
#  type        = string
#  default     = "us-central1"
#}
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
}

variable "cloudbuild_sa" {
  description = "Cloud Build service account email"
  type        = string
}
