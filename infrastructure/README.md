# Infrastructure Subproject

This subproject contains Terraform scripts to provision initial AWS infrastructure for SentiTone.

Structure:
- terraform/ — root Terraform configuration invoking modules
  - modules/
    - database/ — RDS database module
    - eks/ — EKS cluster module

Run Terraform via Gradle tasks from this subproject once configured.
