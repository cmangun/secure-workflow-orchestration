# =============================================================================
# Secure Workflow Orchestration - Variables
# =============================================================================

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "secure-workflow"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,20}$", var.project_name))
    error_message = "Project name must be lowercase alphanumeric with hyphens, 3-21 characters."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "development"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "owner" {
  description = "Team or individual responsible for these resources"
  type        = string
  default     = "platform-team"
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  default     = "engineering"
}

# =============================================================================
# Network Configuration
# =============================================================================

variable "vpc_id" {
  description = "VPC ID for network resources"
  type        = string
  default     = ""  # Must be provided for actual deployment
}

variable "allowed_egress_cidrs" {
  description = "CIDR blocks allowed for egress traffic"
  type        = list(string)
  default = [
    # Example: Package registries, cloud APIs
    # "0.0.0.0/0"  # Not recommended for production
  ]
}

# =============================================================================
# Logging & Retention
# =============================================================================

variable "log_retention_days" {
  description = "Number of days to retain audit logs"
  type        = number
  default     = 90

  validation {
    condition     = var.log_retention_days >= 30
    error_message = "Log retention must be at least 30 days for compliance."
  }
}

# =============================================================================
# Security Controls
# =============================================================================

variable "enable_encryption" {
  description = "Enable encryption at rest for all resources"
  type        = bool
  default     = true
}

variable "enable_audit_logging" {
  description = "Enable detailed audit logging"
  type        = bool
  default     = true
}

variable "allowed_ip_ranges" {
  description = "IP ranges allowed to access workflow infrastructure"
  type        = list(string)
  default     = []  # Must be provided for production
}
