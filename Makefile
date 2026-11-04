SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c

BOOTSTRAP_DIR := environments/bootstrap

.PHONY: help fmt fmt-check validate lint check clean

help: ## Display available targets
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-18s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

fmt: ## Apply canonical formatting across all Terraform configurations
	terraform fmt -recursive

fmt-check: ## Verify canonical formatting across all Terraform configurations
	terraform fmt -check -recursive

validate: ## Validate syntax and internal consistency of modules and bootstrap root
	@echo "===> Validating modules/state-bucket"
	terraform -chdir=modules/state-bucket init -backend=false
	terraform -chdir=modules/state-bucket validate
	@echo "===> Validating modules/workload-identity"
	terraform -chdir=modules/workload-identity init -backend=false
	terraform -chdir=modules/workload-identity validate
	@echo "===> Validating environments/bootstrap"
	terraform -chdir=$(BOOTSTRAP_DIR) init -backend=false
	terraform -chdir=$(BOOTSTRAP_DIR) validate

lint: fmt-check validate ## Run all static formatting and validation checks

clean: ## Remove local ephemeral Terraform files and caches
	find . -type d -name ".terraform" -prune -exec rm -rf {} +
	find . -type f -name ".terraform.lock.hcl" -delete
	find . -type f -name "*.tfstate*" -delete
	find . -type f -name "crash.log" -delete
