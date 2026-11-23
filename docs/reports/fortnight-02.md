# MSc Project: Fortnightly Progress Report 02

<div align="left">

* **Student:** Benjamin Terence Weston (`25030591`) - Tutor Group 1   
* **Supervisor:** Ibrahim   
* **Module:** CSC-44142 - MSc Computer Science Project (Keele University)   
* **Project:** IngotADP - *A Governance-First Modular Hub-and-Spoke Application Delivery Platform*   
* **Reporting Period:** Fortnight 2 (Weeks 3-4: 09 Nov - 22 Nov 2026)   
* **Submission Date:** 24 November 2026
* **Target Milestone:** Milestone 1 (M1 - Architecture & Baseline Design / Core Hub Validated) - **Complete**   
* **Repositories:** [`github.com/ingotadp/ingot-secure`](https://github.com/ingotadp/ingot-secure), [`github.com/ingotadp/ingot-core`](https://github.com/ingotadp/ingot-core)   

</div>

---

## 1. Executive Summary

<div align="left">

During Fortnight 2 (Weeks 3-4), Milestone 1 technical and architectural governance objectives were completed on schedule.  A centralised Policy-as-Code engine was scaffolded and verified in [`ingotadp/ingot-secure`](https://github.com/ingotadp/ingot-secure) (`main` @ `9e210d8`) and enforced across the core hub repository [`ingotadp/ingot-core`](https://github.com/ingotadp/ingot-core) (`main` @ `fcd48b3`). Every pull request targeting `ingot-core` now undergoes automated secret scanning, immutable 40-character SHA action verification, static Infrastructure-as-Code (IaC) misconfiguration scanning, and Open Policy Agent (OPA) evaluation against live Workload Identity Federation (WIF) speculative Terraform plans.  Repository branch protection on `ingot-core` `main` has been hardened to mandate both the centralised security gate and cryptographic commit signatures.   

</div>

---

## 2. Activities Undertaken & Commit Ledger

### 2.1 Verified Commit & Pull Request Evidence

<div align="left">

All commits across both repositories were cryptographically signed using ED25519 SSH signing key `SHA256:80EUyew0hmXhwh7XChThgafgsB/Tnt2KtNo1WN0rm10`.   

| Repository | Branch / PR | Merge Commit (`main`) | Deliverable & Verification Summary |
| :--- | :--- | :--- | :--- |
| `ingotadp/ingot-secure` | `feat/scaffold-policy-engine` (`2e3c5d9`) → **PR `#1`** (Squash) | `9e210d8c0a35966d24803e6799083ce5dd4ffb95` | Scaffolded OPA/Rego v1 policies, `9/9` unit tests, `.gitleaks.toml`, `Policy Engine CI`, and `reusable-security-gate.yml`. |
| `ingotadp/ingot-core` | `chore/enforce-ingot-secure-gate` (`daba30a`) → **PR `#3`** (REST Squash) | `fcd48b3111e1a86a12e87e9d782ae5ea85cea329` | Pinned 7 workflow action references to 40-char SHAs, integrated `reusable-security-gate.yml@9e210d8`, and added OPA speculative plan evaluation. |

</div>

### 2.2 Centralised Policy Engine (`ingotadp/ingot-secure`)

<div align="left">

Established the platform security control plane in `ingotadp/ingot-secure` (9 files added, 312 insertions):   

* **Terraform IAM & WIF Governance (`policies/terraform/wif_iam_security.rego`):** Enforces least-privilege IAM bindings and Workload Identity Federation attribute conditions under namespace `ingot.terraform.security`.   
* **GitHub Actions Supply-Chain Integrity (`policies/github-actions/workflow_security.rego`):** Prohibits mutable version tags (`@v3`, `@v4`, `@main`) on third-party `uses:` steps under namespace `ingot.github_actions.security`, requiring immutable 40-character commit SHAs.   
* **Container Hardening (`policies/containers/dockerfile_security.rego`):** Validates non-root runtime execution and digest-pinned base images via Conftest in preparation for workload spoke onboarding.   
* **Self-Validating Policy CI (`.github/workflows/policy-ci.yml`):** Executes `opa fmt --check`, `opa test` (`9/9` unit tests passing), `conftest test` self-linting on repository workflows, and `gitleaks detect` on every pull request.   
* **Reusable Spoke Gate (`.github/workflows/reusable-security-gate.yml`):** Exposes a standardised `workflow_call` pipeline (`IngotADP Pre-Merge Security Gate`) combining Gitleaks secret detection, Conftest workflow validation, and Trivy IaC misconfiguration scanning (`HIGH` and `CRITICAL` severities).   

</div>

### 2.3 Hub CI/CD Integration & Supply-Chain Hardening (`ingotadp/ingot-core`)

<div align="left">

Integrated `ingot-secure` controls into `ingotadp/ingot-core` and verified end-to-end execution across PR `#3`:   

* **Immutable Action Pinning:** Baseline local auditing via Conftest identified 7 unpinned action tags across `.github/workflows/lint.yml` and `.github/workflows/plan.yml`. All third-party dependencies were pinned to verified 40-character commit SHAs:   
  * `actions/checkout@11d5960a326750d5838078e36cf38b85af677262` (`v4`)   
  * `hashicorp/setup-terraform@b9cd54a3c349d3f38e8881555d616ced269862dd` (`v3`)   
  * `google-github-actions/auth@c200f3691d83b41bf9bbd8638997a462592937ed` (`v2`)   
* **Reusable Gate Integration (`.github/workflows/lint.yml`):** Added the `security-gate` job (`IngotADP Security Gate`) referencing `ingotadp/ingot-secure/.github/workflows/reusable-security-gate.yml@9e210d8c0a35966d24803e6799083ce5dd4ffb95` with `run-iac-scan: true`.   
* **Speculative Terraform Plan Policy Evaluation (`.github/workflows/plan.yml`):** Extended the WIF-authenticated speculative plan pipeline (`ingot-gha-runner@ingotadp-core.iam.gserviceaccount.com`) to export binary plans to JSON (`terraform show -json`) and validate `tfplan.json` directly against `.ingot-secure/policies/terraform` (`ingot.terraform.security`) via Conftest before merge.   
* **End-to-End CI Verification (PR `#3`):** All four required checks completed cleanly:   
  * `Terraform Lint and Validate / Check Formatting (pull_request)` - **Pass** (`6s`)   
  * `Terraform Lint and Validate / IngotADP Security Gate / IngotADP Pre-Merge Security Gate` - **Pass** (`9s`)   
  * `Terraform Lint and Validate / Validate Modules and Environments (pull_request)` - **Pass** (`16s`)   
  * `Terraform Speculative Plan / Speculative Plan (Bootstrap) (pull_request)` - **Pass** (`32s`)   

</div>

### 2.4 Branch Protection & Provenance Enforcement (`ingotadp/ingot-core`)

<div align="left">

Hardened the `main` branch protection policy on `ingotadp/ingot-core` via the GitHub Branch Protection API:   

* **Mandatory Security Gate Status Check:** Updated `required_status_checks` (`strict: true`) to require `"IngotADP Security Gate / IngotADP Pre-Merge Security Gate"` (`app_id: 15368`) alongside existing Terraform formatting, module validation, and speculative plan checks.   
* **Mandatory Cryptographic Commit Signatures:** Enabled `required_signatures: true` (`POST /repos/ingotadp/ingot-core/branches/main/protection/required_signatures`), blocking any unsigned commit or unverified merge from landing on `main`.   

</div>

### 2.5 Spoke Staging & Formative Academic Deliverables

<div align="left">

* Verified local clones of all remaining organisation repositories (`ingot-build`, `ingot-observe`, `ingot-sandbox`, and `.github`) in preparation for Milestone 2 spoke integration.   
* Completed (but not yet submitted) the formative MSc Project Development Poster (`6.3: Formative Assessment - MSc Project Development Poster`), aligning architectural motivation, methodology, and evaluation design with Intended Learning Outcomes (ILOs 1–5).   

</div>

---

## 3. Evaluation Against Project Milestones (M1–M5)

<div align="left">

| Milestone | Planned Window | Current Status | Evaluation Notes |
| :--- | :--- | :--- | :--- |
| **M1: Architecture & Baseline Design** | Weeks 1–4 | **Complete (Green)** | Hub Google Cloud bootstrap, remote GCS state locking, keyless WIF OIDC, centralised OPA/Rego policy engine (`ingot-secure`), and strict branch protection (`ingot-core`) are all live and verified at the end of Week 4. |
| **M2: Platform MVP Build & Spoke Integration** | Weeks 5–11 | **Scheduled Next** | Entering Week 5 on schedule with local spoke repositories cloned and the reusable `ingot-secure` gate published at immutable SHA `9e210d8`. |
| **M3: Telemetry & Testbed Operationalisation** | Weeks 12–15 | **Planned** | Dependent on M2 integration of `ingot-observe` and `ingot-sandbox`. |
| **M4: Empirical Evaluation & Benchmarking** | Weeks 16–19 | **Planned** | CI execution durations (`6s`–`32s`) and policy audit metrics are already being recorded in GitHub Actions run logs to establish baseline governance overhead. |
| **M5: Final Dissertation Synthesis & Submission** | Weeks 20–24 | **Planned** | Continuous commit-linked evidence reports (`fortnight-01.md`, `fortnight-02.md`) preserve reproducible audit trails for dissertation synthesis. |

</div>

---

## 4. Issues & Challenges Encountered

<div align="left">

1. **Reusable Workflow Runner Isolation for Speculative Plans:**   
   * *Challenge:* GitHub Actions `workflow_call` jobs execute on isolated runner VMs and cannot directly access untracked binary `tfplan` files generated inside `plan.yml`.   
   * *Resolution:* Separated static and dynamic policy checks cleanly: Gitleaks secret scanning, Conftest workflow linting, and static Trivy IaC scanning run inside `reusable-security-gate.yml`, while `plan.yml` checks out `ingotadp/ingot-secure` at pinned commit `9e210d8` to evaluate the WIF-generated `tfplan.json` locally via Conftest.   
2. **GitHub Checks API Context Naming & GraphQL Merge Fault:**   
   * *Challenge:* GitHub's Checks API registers reusable workflow jobs using the composite naming convention `<caller_job> / <callee_job>` (`IngotADP Security Gate / IngotADP Pre-Merge Security Gate`, `app_id: 15368`) rather than the workflow filename prefix. Additionally, `gh pr merge --squash --delete-branch` encountered a transient GitHub GraphQL 500 error (`E1B2:1CA009:3FA05AD:60945B2:6AFB01AF`) on PR `#3`.
   * *Resolution:* Verified the exact check-run context via `GET /repos/ingotadp/ingot-core/commits/daba30a/check-runs`, completed the squash merge deterministically via the GitHub REST API (`PUT /repos/ingotadp/ingot-core/pulls/3/merge`), and patched `required_status_checks` with the exact Checks API context string.

</div>

---

## 5. Plan for the Upcoming Fortnight (Weeks 5–6: 23 Nov – 06 Dec 2026)

<div align="left">

1. **Onboard Remaining Spokes to `ingot-secure`:** Wire `ingotadp/ingot-secure/.github/workflows/reusable-security-gate.yml@9e210d8c0a35966d24803e6799083ce5dd4ffb95` and SHA-pinned GitHub Actions into **`ingot-build`**, **`ingot-observe`**, **`ingot-sandbox`**, and **`.github`**.   
2. **Standardise Organisation Branch Protection:** Apply `required_status_checks` (`strict: true` requiring `IngotADP Security Gate / IngotADP Pre-Merge Security Gate`) and `required_signatures: true` across `ingot-secure` and all onboarded spoke repositories.   
3. **Scaffold Build & Container Validation Pipeline (`ingot-build`):** Implement the workload container build workflow in `ingot-build`, integrating Conftest Dockerfile validation (`policies/containers/dockerfile_security.rego`) and Trivy container image vulnerability gates ahead of `ingot-sandbox` deployment.   

</div>
