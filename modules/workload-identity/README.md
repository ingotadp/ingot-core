<a href="https://github.com/benweston/ingot-core">
    <img
        src="/assets/banners/main-banner.png"
        alt="A Modern, Highly Modular Hub-and-Spoke Application Delivery Platform (ADP)"
        width="1100"
        height="250"
        loading="lazy"
    />
</a>

# Workload Identity Federation Module

<div align="justify">

> Reusable Terraform module provisioning Google Cloud Workload Identity Federation (WIF) for keyless GitHub Actions authentication.   

</div>

## Architecture

<div align="justify">

- Creates a dedicated `google_iam_workload_identity_pool`.   
- Configures an OIDC provider mapped to `https://token.actions.githubusercontent.com`.   
- Restricts federation strictly to the configured GitHub organisation via `assertion.repository_owner`.   
- Provisions a dedicated Service Account and binds project-level roles without static long-lived keys.   

</div>

## Outputs

<div align="justify">

- `provider_name`: Full provider resource string required by `google-github-actions/auth`.   
- `service_account_email`: Service account email to impersonate.   

</div>
