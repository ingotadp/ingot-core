provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Core APIs required for IAM federation, Resource Manager, and Cloud Storage
locals {
  required_services = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
    "storage.googleapis.com"
  ]
}

resource "google_project_service" "required_apis" {
  for_each = toset(local.required_services)

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

# 1. State Storage Primitive
module "state_bucket" {
  source = "../../modules/state-bucket"

  project_id = var.project_id
  name       = var.storage_bucket_name
  location   = var.region

  depends_on = [google_project_service.required_apis]
}

# 2. Keyless GitHub Actions OIDC Trust Boundary
module "workload_identity" {
  source = "../../modules/workload-identity"

  project_id         = var.project_id
  github_org         = var.github_org
  pool_id            = var.wif_pool_id
  provider_id        = var.wif_provider_id
  service_account_id = var.runner_service_account_id

  roles = [
    "roles/storage.admin",
    "roles/iam.workloadIdentityUser"
  ]

  depends_on = [google_project_service.required_apis]
}
