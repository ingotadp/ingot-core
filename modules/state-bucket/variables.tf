variable "project_id" {
  description = "The Google Cloud project ID where the state bucket resides."
  type        = string
}

variable "name" {
  description = "The globally unique name of the Google Cloud Storage bucket."
  type        = string
}

variable "location" {
  description = "The geographical location or multi-region of the bucket."
  type        = string
  default     = "EUROPE-WEST2" # London
}

variable "storage_class" {
  description = "The storage class of the bucket."
  type        = string
  default     = "STANDARD"
}

variable "prevent_destroy" {
  description = "Whether to prevent accidental destruction of the bucket via Terraform lifecycle rules."
  type        = bool
  default     = true
}
