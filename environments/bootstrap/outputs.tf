output "state_bucket_name" {
  description = "The name of the GCS bucket storing remote Terraform state."
  value       = module.state_bucket.name
}

output "state_bucket_url" {
  description = "The gs:// URI of the GCS bucket storing remote Terraform state."
  value       = module.state_bucket.url
}

output "workload_identity_pool_name" {
  description = "The fully qualified resource identifier of the Workload Identity Pool."
  value       = module.workload_identity.pool_name
}

output "workload_identity_provider_name" {
  description = "The fully qualified resource identifier of the Workload Identity Provider for GitHub Actions."
  value       = module.workload_identity.provider_name
}

output "runner_service_account_email" {
  description = "The email address of the service account impersonated by GitHub Actions."
  value       = module.workload_identity.service_account_email
}
