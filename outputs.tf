output "bucket_name" {
  value = google_storage_bucket.log_bucket.name
}

output "bucket_url" {
  value = google_storage_bucket.log_bucket.url
}
