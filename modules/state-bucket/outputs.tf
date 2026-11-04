output "name" {
  description = "The name of the state storage bucket."
  value       = google_storage_bucket.main.name
}

output "url" {
  description = "The base gs:// URL of the state storage bucket."
  value       = google_storage_bucket.main.url
}
