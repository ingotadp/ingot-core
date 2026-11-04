variable "project_id" {
  description = "The target Google Cloud project ID where foundational IngotADP resources will reside."
  type        = string
}

variable "region" {
  description = "The default Google Cloud compute and storage region."
  type        = string
  default     = "europe-west2" # London
}

variable "storage_bucket_name" {
  description = "The globally unique name for the remote Terraform state Google Cloud Storage bucket."
  type        = string
}

variable "github_org" {
  description = "The GitHub organisation authorised to federate with Google Cloud via OIDC."
  type        = string
  default     = "ingotadp"
}

variable "wif_pool_id" {
  description = "The identifier for the Workload Identity Pool."
  type        = string
  default     = "ingot-github-pool"
}

variable "wif_provider_id" {
  description = "The identifier for the Workload Identity Provider."
  type        = string
  default     = "ingot-github-provider"
}

variable "runner_service_account_id" {
  description = "The account ID for the dedicated GitHub Actions runner Service Account."
  type        = string
  default     = "ingot-gha-runner"
}
