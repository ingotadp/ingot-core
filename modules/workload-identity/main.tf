resource "google_iam_workload_identity_pool" "main" {
  project                   = var.project_id
  workload_identity_pool_id = var.pool_id
  display_name              = "IngotADP GitHub Actions Pool"
  description               = "Identity pool federating GitHub Actions OIDC tokens for IngotADP workflows."
}

resource "google_iam_workload_identity_pool_provider" "main" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.main.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = "IngotADP GitHub Provider"
  description                        = "OIDC identity provider mapping GitHub Actions workflow assertions."

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  attribute_condition = "assertion.repository_owner == '${var.github_org}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "main" {
  project      = var.project_id
  account_id   = var.service_account_id
  display_name = "IngotADP GitHub Actions Runner"
  description  = "Service account assumed by GitHub Actions via Workload Identity Federation."
}
