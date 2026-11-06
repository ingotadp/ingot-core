<a href="https://github.com/ingotadp/ingot-core">
    <img
        src="/assets/banners/main-banner.png"
        alt="A Modern, Highly Modular Hub-and-Spoke Application Delivery Platform (ADP)"
        width="1100"
        height="250"
        loading="lazy"
    />
</a>

# State Bucket Module

<div align="justify">

> Reusable Terraform module managing foundational Google Cloud Storage (GCS) buckets for remote backend state storage and state locking across IngotADP.   

</div>

## Features

<div align="justify">

- Uniform bucket-level access control enforced.   
- Public access prevention enforced (`enforced`).   
- Object versioning enabled to prevent state corruption.   
- Lifecycle protection enabled (`prevent_destroy = true`).   

</div>

## Usage

```hcl
module "state_bucket" {
  source     = "../../modules/state-bucket"
  project_id = var.project_id
  name       = "bwt-ingotadp-tfstate"
  location   = "EUROPE-WEST2"
}
