terraform {
  backend "gcs" {
    bucket = "ingotadp-tfstate-europe-west2"
    prefix = "ingot-core/bootstrap"
  }
}
