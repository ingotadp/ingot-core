resource "google_storage_bucket" "main" {
  name          = var.name
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
