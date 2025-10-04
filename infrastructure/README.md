# Infrastructure Subproject

This subproject contains Terraform scripts to provision initial AWS infrastructure for SentiTone. Terraform is executed via the Gradle Terraform plugin from this subproject.

Structure:
- terraform/ — root Terraform configuration invoking modules
  - modules/
    - database/ — Amazon RDS for PostgreSQL module
    - cluster/ — Amazon EKS cluster (control plane) module
    - ingress/ — Helm-based ingress controller (Traefik) module (scaffolded; requires Kubernetes/Helm providers at root)

## Prerequisites
- AWS account and IAM user/role with sufficient permissions
- S3 bucket for Terraform remote state (created by the manual-initial-stack.yaml or manually)
- Terraform 1.13.x (configured by Gradle)
- Gradle properties provided at invocation time:
  - secretKeyId — AWS access key ID
  - secretAccessKey — AWS secret access key
  - region — AWS region (default: eu-west-1)
  - env — environment name (e.g., dev, stg, prod)
  - mainBucket — S3 bucket name for remote state (e.g., <account>-sentitone)
  - dbPassword — database password for the RDS instance

## Usage
From the project root (or this subproject directory), run:

- Initialize Terraform backend and workspace:
  gradlew :infrastructure:tfInit -PsecretKeyId=... -PsecretAccessKey=... -Pregion=eu-west-1 -Penv=dev -PmainBucket=<account>-sentitone -PdbPassword=...

- Plan changes:
  gradlew :infrastructure:tfPlan -PsecretKeyId=... -PsecretAccessKey=... -Pregion=eu-west-1 -Penv=dev -PmainBucket=<account>-sentitone -PdbPassword=...

- Apply changes:
  gradlew :infrastructure:tfApply -PsecretKeyId=... -PsecretAccessKey=... -Pregion=eu-west-1 -Penv=dev -PmainBucket=<account>-sentitone -PdbPassword=...

Notes:
- The current database module is configured to allow public access (publicly_accessible=true) and its security group ingress is wide open to 0.0.0.0/0. This is NOT suitable for production. Tighten access before use in shared or prod environments.
- The ingress module is scaffolded and depends on Kubernetes and Helm providers configured at the root, which are not yet present.
