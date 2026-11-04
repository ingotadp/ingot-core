# Authorise GitHub repositories within the organisation to impersonate the Service Account
resource "google_service_account_iam_member" "workload_identity_user" {
  service_account_id = google_service_account.main.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/attribute.repository_owner/${var.github_org}"
}

# Assign required project-level capabilities to the federated Service Account
resource "google_project_iam_member" "roles" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.main.email}"
}
