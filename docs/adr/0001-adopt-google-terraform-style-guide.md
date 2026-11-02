# 1. Adopt Google Cloud Terraform Style and Structural Standards

<div align="left">

Date: 2026-11-02   

</div>

## Status

<div align="left">

Accepted   

</div>

## Context

<div align="left">

IngotADP requires a consistent, maintainable, and predictable Infrastructure as Code (IaC) topology across its foundational platform hub (`ingot-core`). Without codified conventions, module interfaces quickly diverge in variable naming, output formats, and dependency structures.   

</div>

## Decision

<div align="left">

We adopt the official Google Cloud Terraform Style and Structure Best Practices as the architectural standard for `ingot-core`.   

Key standards enforced:   
1. **Standard Module Hierarchy:** Strict layout separating `modules/`, `environments/`, and `docs/`. Every module contains `main.tf`, `variables.tf`, `outputs.tf`, and an isolated `README.md`.   
2. **Naming Conventions:** Underscore notation for configuration objects (e.g. `google_compute_instance.web_server`), singular resource names, and designating singleton resources as `main`.   
3. **Variable Governance:** Explicit types and descriptions on all variables. Metric units declared directly in variable names (e.g. `_gb`, `_mb`).   
4. **Lifecycle Protection:** Stateful resources must declare `prevent_destroy = true`.   
5. **Formatting:** Automated verification using `terraform fmt -check` in CI.   

</div>

## Consequences

<div align="left">

* **Positive:** Consistent module contracts; aligns with enterprise GCP architecture; provides clear provenance for dissertation methodology.   
* **Negative:** Requires upfront schema compliance and CI linting checks.   

</div>

## References

<div align="left">

* `docs/references/gcp-terraform-style-guide.md`   

</div>
