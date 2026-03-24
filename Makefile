# Directory where Terraform files are (current folder)
TF_DIR=terraform

# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "make init      - Initialize Terraform"
	@echo "make infra     - Create infrastructure"
	@echo "make destroy   - Destroy infrastructure"
	@echo "make fmt       - Format Terraform code"
	@echo "make validate  - Validate Terraform config"

# Init Terraform
.PHONY: init
init:
	cd $(TF_DIR) && terraform init

# Apply / Create infrastructure
.PHONY: infra
infra: init
	cd $(TF_DIR) && terraform apply -auto-approve

# Destroy infrastructure
.PHONY: destroy
destroy:
	cd $(TF_DIR) && terraform destroy -auto-approve

# Format Terraform code
.PHONY: fmt
fmt:
	cd $(TF_DIR) && terraform fmt -recursive

# Validate Terraform config
.PHONY: validate
validate:
	cd $(TF_DIR) && terraform validate
