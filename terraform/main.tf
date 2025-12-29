# =============================================================================
# Secure Workflow Orchestration - Main Terraform Configuration
# =============================================================================
# 
# This is a SCAFFOLD/TEMPLATE file demonstrating secure CI/CD infrastructure
# patterns for AI/ML workloads in regulated environments.
#
# DO NOT apply this directly - customize for your cloud provider and
# security requirements.
# =============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    # Uncomment and configure for your cloud provider
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 5.0"
    # }
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~> 3.0"
    # }
    # google = {
    #   source  = "hashicorp/google"
    #   version = "~> 5.0"
    # }
  }

  # Backend configuration for state management
  # Uncomment and customize for your environment
  # backend "s3" {
  #   bucket         = "my-terraform-state"
  #   key            = "secure-workflow/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks"
  # }
}

# =============================================================================
# Local Values
# =============================================================================

locals {
  # Common tags for all resources
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
    CostCenter  = var.cost_center
  }

  # Naming convention
  name_prefix = "${var.project_name}-${var.environment}"
}

# =============================================================================
# Network Security (Example Pattern)
# =============================================================================

# This demonstrates the pattern - uncomment and customize for your provider

# resource "aws_security_group" "workflow_runner" {
#   name_prefix = "${local.name_prefix}-runner-"
#   description = "Security group for CI/CD workflow runners"
#   vpc_id      = var.vpc_id
#
#   # Egress: Only allow specific destinations
#   egress {
#     description = "HTTPS to package registries"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = var.allowed_egress_cidrs
#   }
#
#   # No ingress by default
#   # Add specific rules based on your requirements
#
#   tags = merge(local.common_tags, {
#     Name = "${local.name_prefix}-runner-sg"
#   })
# }

# =============================================================================
# Secrets Management (Example Pattern)
# =============================================================================

# resource "aws_secretsmanager_secret" "workflow_secrets" {
#   name_prefix = "${local.name_prefix}-secrets-"
#   description = "Secrets for CI/CD workflows"
#
#   tags = local.common_tags
# }

# =============================================================================
# Audit Logging (Example Pattern)
# =============================================================================

# resource "aws_cloudwatch_log_group" "workflow_audit" {
#   name              = "/workflow/${local.name_prefix}/audit"
#   retention_in_days = var.log_retention_days
#
#   tags = local.common_tags
# }

# =============================================================================
# Output Values
# =============================================================================

output "scaffold_status" {
  description = "Confirmation that scaffold is valid"
  value       = "Terraform scaffold validated successfully"
}

output "name_prefix" {
  description = "Naming prefix for resources"
  value       = local.name_prefix
}
