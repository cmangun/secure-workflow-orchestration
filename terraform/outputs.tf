# =============================================================================
# Secure Workflow Orchestration - Outputs
# =============================================================================

output "project_name" {
  description = "Project name used for resource naming"
  value       = var.project_name
}

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "common_tags" {
  description = "Common tags applied to all resources"
  value       = local.common_tags
}

# =============================================================================
# Network Outputs (uncomment when resources are created)
# =============================================================================

# output "runner_security_group_id" {
#   description = "Security group ID for workflow runners"
#   value       = aws_security_group.workflow_runner.id
# }

# =============================================================================
# Secrets Outputs
# =============================================================================

# output "secrets_arn" {
#   description = "ARN of the workflow secrets"
#   value       = aws_secretsmanager_secret.workflow_secrets.arn
#   sensitive   = true
# }

# =============================================================================
# Logging Outputs
# =============================================================================

# output "audit_log_group_name" {
#   description = "CloudWatch log group for audit logs"
#   value       = aws_cloudwatch_log_group.workflow_audit.name
# }
