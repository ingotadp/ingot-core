# 2. Ingot-Core Directory Topology and Separation of Concerns

<div align="left">

Date: 2026-11-04

</div>

## Status

<div align="left">

Accepted

</div>

## Context

<div align="left">

Following the adoption of the Google Cloud Terraform Style Guide (ADR-001), `ingot-core` requires a concrete directory structure.  The repository acts as the authoritative platform control plane, responsible for remote state management, zero-trust Workload Identity Federation (WIF), and base cloud primitives.   

To prevent tight coupling between reusable infrastructure components and environment-specific runtime configurations, we require an explicit separation between module definitions, root environment orchestrations, and automated governance pipelines.   

</div>

## Decision

<div align="left">

We establish a two-tier directory layout separating reusable building blocks (`modules/`) from environment entry points (`environments/`):   

1. **`modules/` (Component Layer):**   
   * Encapsulates self-contained, composable Terraform modules (`state-bucket`, `workload-identity`).   
   * Each module must strictly contain `main.tf`, `variables.tf`, `outputs.tf`, and an isolated `README.md`.   
   * Modules must remain stateless and environment-agnostic.   

2. **`environments/` (Composition Layer):**   
   * Contains root modules responsible for instantiating component modules.   
   * `environments/bootstrap/` serves as the initial root module to provision state storage and GitHub Actions WIF credentials.   
   * Houses `backend.tf`, `versions.tf`, and `terraform.tfvars.example`.   

3. **`Makefile` (Developer Interface):**   
   * Standardises local commands for formatting, validation, and linting (`fmt`, `validate`, `lint`) across workstations.   

4. **`.github/workflows/` (Automation & Governance):**   
   * Houses isolated pipelines for static code analysis (`lint.yml`) and speculative pull request evaluation (`plan.yml`).   

</div>

## Consequences

<div align="left">

* **Positive:** Clear decoupling of reusable modules from environment state; modular testing isolation; eliminates circular dependencies; satisfies dissertation Research Objectives RO1 and RO2.
* **Negative:** Slightly increased file overhead compared to a flat root module; requires careful input/output plumbing between modules.

</div>

## References

<div align="left">

* ADR-001: Adopt Google Cloud Terraform Style and Structural Standards   
* `docs/references/gcp-terraform-style-guide.md`   

</div>
