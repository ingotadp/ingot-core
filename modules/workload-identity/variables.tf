variable "project_id" {
  description = "The Google Cloud project ID hosting the Workload Identity Federation resources."
  type        = string
}

variable "pool_id" {
  description = "The identifier for the Workload Identity Pool (must be 4-32 characters, lowercase alphanumeric and hyphens)."
  type        = string
  default     = "ingot-github-pool"
}

variable "provider_id" {
  description = "The identifier for the Workload Identity Provider."
  type        = string
  default     = "ingot-github-provider"
}

variable "github_org" {
  description = "The GitHub organisation authorised to federate with Google Cloud."
  type        = string
  default     = "ingotadp"
}

variable "service_account_id" {
  description = "The account ID for the dedicated GitHub Actions runner Service Account."
  type        = string
  default     = "ingot-gha-runner"
}

variable "roles" {
  description = "The list of IAM roles to grant to the federated Service Account."
  type        = list(string)
  default = [
    "roles/storage.admin",
    "roles/iam.workloadIdentityUser"
  ]
}
