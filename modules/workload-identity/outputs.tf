output "pool_name" {
  description = "The resource name of the Workload Identity Pool."
  value       = google_iam_workload_identity_pool.main.name
}

output "provider_name" {
  description = "The fully qualified resource identifier of the Workload Identity Provider."
  value       = google_iam_workload_identity_pool_provider.main.name
}

output "service_account_email" {
  description = "The email address of the federated Service Account."
  value       = google_service_account.main.email
}
