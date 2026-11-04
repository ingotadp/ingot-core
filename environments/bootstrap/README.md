# IngotADP Core: Bootstrap Environment

Foundational hub environment managing core control-plane primitives:
- Authoritative Google Cloud APIs (`cloudresourcemanager`, `iam`, `sts`, `storage`)
- Remote Terraform State Storage Bucket (`ingotadp-tfstate-europe-west2`)
- Workload Identity Federation (WIF) Pool and GitHub Actions OIDC Provider
- GitHub Actions Runner Service Account and IAM role bindings
