# MSc Dissertation Bi-Weekly Progress Report

<div align="left">

**Project Title:** IngotADP: A Governance-First Modular Hub-and-Spoke Application Delivery Platform   
**Student:** Benjamin Terence Weston   
**Reporting Period:** Fortnight 1 (Weeks 1–2) - 26 October 2026 to 08 November 2026   
**Target Milestone:** Milestone 1 (M1 - Core Hub Validated)   

</div>

---

### 1. Activities Undertaken in the Past Two Weeks

<div align="left">

Primary technical work during Fortnight 1 concentrated on provisioning the foundational control plane and establishing automated, keyless CI governance within the core hub repository (`ingot-core`). To ensure reproducibility and an auditable academic record, each completed deliverable below is linked directly to its verified Git commit hash or merged pull request:   

- **Core Cloud Architecture & Organisation Setup:**   
  - Configured the central control plane project `ingotadp-core` (Project Number: `76811299324`) under the `ingotadp.io` Google Cloud Organisation (`435934533862`).   
  - Established the foundational repository layout separating reusable modules from root environments (Commit `7668956`).   

- **Stateless Modular Infrastructure:**   
  - Implemented the reusable `state-bucket` module, provisioning a regional Google Cloud Storage bucket (`gs://ingotadp-tfstate-europe-west2`) configured with mandatory object versioning, Google-managed encryption, and public access prevention.   
  - Implemented the `workload-identity` module, establishing a dedicated Google Cloud Workload Identity Federation (WIF) pool (`ingot-github-pool`) and GitHub Actions OIDC provider (`ingot-github-provider`).   

- **Remote State Migration & Bootstrap Composition:**   
  - Composed the root environment (`environments/bootstrap`), provisioning authoritative IAM, STS, and Cloud Resource Manager APIs alongside core storage and identity primitives.   
  - Successfully migrated local Terraform state into `gs://ingotadp-tfstate-europe-west2` via `terraform init -migrate-state` with zero resource drift (Commit `7668956`).   

- **Automated CI/CD Governance & Keyless OIDC Verification:**   
  - Deployed pre-merge GitHub Actions workflows (`lint.yml` and `plan.yml`) enforcing recursive formatting, module syntax validation, and speculative planning (Commit `5fe6aaa`).   
  - Authenticated and verified end-to-end keyless STS token exchange via Workload Identity Federation on Pull Request #1 (Commit `0e06fef`, GitHub Actions Run #`41842157597`).   
  - Enforced strict branch protection on `main`, requiring passing checks across code formatting, module validation, and speculative planning prior to merging.      

- **Architectural Documentation & Declarative State Parity:**   
  - Standardised architectural documentation across `modules/` and `environments/` with structural banners and descriptive component summaries (Commit `f697033`).
  - Resolved API discovery permissions during state refresh and codified `serviceusage.googleapis.com` into declarative configuration to achieve zero plan drift (Commit `f339188`).   

</div>

---

### 2. Plan for the Upcoming Two Weeks (Weeks 3–4)

<div align="left">

Focus for Fortnight 2 shifts to completing the formal sign-off of Milestone 1 and preparing spoke orchestration:   

1. **Spoke Landing Zone Design:** Scaffold repository templates and baseline Terraform configurations for the execution spokes (`ingot-build`, `ingot-secure`, `ingot-observe`, `ingot-sandbox`).   
2. **Formal Phase 1 / Milestone 1 (M1) Sign-Off:** Complete architectural baseline documentation and compile design artefacts for the Week 4 milestone gate.   
3. **Phase 2 Baseline Preparation:** Outline policy enforcement specifications using Open Policy Agent (OPA/Rego) ahead of Phase 2 build and security spoke implementation.   

</div>

---

### 3. Evaluation Against Plan / Milestone Status

<div align="left">

- **Current Milestone Target:** Milestone 1 (M1 – Core Hub Validated) due at the end of Week 4.   
- **Current Status:** **Green / Ahead of Schedule**.   
- **Assessment:** Core cloud primitives, keyless OIDC authentication, remote state management, and automated speculative planning are fully operational and verified without configuration drift. The project is approximately one to two weeks ahead of the initial delivery schedule, providing ample buffer for spoke architecture design.   

</div>

---

### 4. Issues or Challenges Encountered

<div align="left">

- **API Authorisation During Terraform Plan Refresh:**   
  - *Symptom:* The GitHub Actions speculative plan failed with HTTP 403 (`serviceusage.services.list` permission denied) during the state refresh phase (PR #1 / Run #41842157597).   
  - *Root Cause:* The runner service account lacked permission to enumerate enabled APIs across the project during provider inspection.   
  - *Resolution:* Attached `roles/serviceusage.serviceUsageViewer` to the runner service account and declared `serviceusage.googleapis.com` within `local.required_services` in `environments/bootstrap/main.tf`, eliminating drift (`f339188`).   
- **Workflow Parsing Pre-flight Check:**   
  - *Symptom:* Initial workflow triggers failed immediately at 0s with log retrieval errors.   
  - *Root Cause:* Workflow files were initially created as empty 0-byte stubs.   
  - *Resolution:* Populated complete schemas for `lint.yml` and `plan.yml`, followed by successful execution (`5fe6aaa`).   

</div>
