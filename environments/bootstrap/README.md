<a href="https://github.com/ingotadp/ingot-core">
    <img
        src="/assets/banners/main-banner.png"
        alt="A Modern, Highly Modular Hub-and-Spoke Application Delivery Platform (ADP)"
        width="1100"
        height="250"
        loading="lazy"
    />
</a>

# IngotADP Core: Bootstrap Environment

<div align="justify">

Foundational hub environment managing core control-plane primitives:   
- Authoritative Google Cloud APIs (`cloudresourcemanager`, `iam`, `sts`, `storage`)   
- Remote Terraform State Storage Bucket (`ingotadp-tfstate-europe-west2`)   
- Workload Identity Federation (WIF) Pool and GitHub Actions OIDC Provider   
- GitHub Actions Runner Service Account and IAM role bindings   

</div>
