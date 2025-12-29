# Secure Workflow Orchestration

[![CI](https://github.com/cmangun/secure-workflow-orchestration/actions/workflows/ci.yml/badge.svg)](https://github.com/cmangun/secure-workflow-orchestration/actions/workflows/ci.yml)

Portable CI/CD security patterns and infrastructure templates for regulated AI/ML deployments.

## Overview

This repository provides security-focused CI/CD patterns for organizations deploying AI/ML workloads in regulated environments (healthcare, finance, pharmaceuticals). It includes Terraform templates, threat models, and compliance mappings.

## What's Included

```
secure-workflow-orchestration/
├── terraform/           # Infrastructure templates
│   ├── main.tf         # Main configuration (scaffold)
│   ├── variables.tf    # Configurable inputs
│   └── outputs.tf      # Output values
├── docs/
│   ├── threat-model.md      # STRIDE-based threat analysis
│   └── controls-mapping.md  # Compliance framework mapping
├── scripts/
│   └── check.sh        # Validation script
└── .github/workflows/
    └── ci.yml          # CI pipeline
```

## Security Patterns

### 1. Network Isolation

- Dedicated VPC for CI/CD runners
- Explicit egress allowlists
- No direct internet ingress

### 2. Secrets Management

- Short-lived credentials
- Automatic rotation
- No secrets in code or logs

### 3. Artifact Integrity

- Signed artifacts (cosign/GPG)
- SBOM generation
- Immutable storage

### 4. Audit Logging

- Complete audit trail
- Immutable log storage
- Anomaly detection

## Compliance Coverage

| Framework | Coverage | Documentation |
|-----------|----------|---------------|
| SOC 2 Type II | Partial | [Controls Mapping](docs/controls-mapping.md) |
| HIPAA | Partial | [Controls Mapping](docs/controls-mapping.md) |
| PCI DSS | Partial | [Controls Mapping](docs/controls-mapping.md) |
| FDA 21 CFR Part 11 | Partial | [Controls Mapping](docs/controls-mapping.md) |

## Quickstart

```bash
# Clone
git clone https://github.com/cmangun/secure-workflow-orchestration.git
cd secure-workflow-orchestration

# Validate Terraform
cd terraform
terraform init -backend=false
terraform validate
terraform fmt -check

# Run validation script
cd ..
chmod +x scripts/check.sh
./scripts/check.sh
```

## Usage

### 1. Review Threat Model

Start with the [threat model](docs/threat-model.md) to understand security considerations for your environment.

### 2. Customize Terraform

The Terraform files are scaffolds. Uncomment and customize for your cloud provider:

```hcl
# terraform/main.tf
# Uncomment and configure for AWS/Azure/GCP

provider "aws" {
  region = "us-east-1"
}

# Enable the security group resource
resource "aws_security_group" "workflow_runner" {
  # ...
}
```

### 3. Configure Variables

```bash
# terraform.tfvars
project_name = "my-project"
environment  = "production"
vpc_id       = "vpc-12345678"
```

### 4. Apply Controls Mapping

Use the [controls mapping](docs/controls-mapping.md) to document your compliance posture.

## Integration Examples

### GitHub Actions

```yaml
# .github/workflows/secure-build.yml
name: Secure Build

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      id-token: write  # For OIDC
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Build and Sign
        run: |
          # Build artifact
          npm run build
          
          # Sign with cosign (example)
          # cosign sign-blob --output-signature dist/app.sig dist/app.tar.gz
```

### GitLab CI

```yaml
# .gitlab-ci.yml
stages:
  - build
  - sign
  - deploy

build:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - dist/

sign:
  stage: sign
  script:
    - # Sign artifacts
  needs: [build]
```

## Next Iterations

- [ ] Add AWS/Azure/GCP provider configurations
- [ ] Add signed build provenance (SLSA)
- [ ] Add environment promotion gates
- [ ] Add incident response playbooks
- [ ] Add cost estimation
- [ ] Add multi-cloud support

## License

MIT © Christopher Mangun

---

**Portfolio**: [field-deployed-engineer.vercel.app](https://field-deployed-engineer.vercel.app/)  
**Contact**: Christopher Mangun — Brooklyn, NY
