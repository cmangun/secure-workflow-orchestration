#!/usr/bin/env bash
# =============================================================================
# Secure Workflow Orchestration - Validation Script
# =============================================================================

set -euo pipefail

echo "🔍 Validating secure-workflow-orchestration scaffold..."
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

ERRORS=0

check() {
    local desc="$1"
    local cmd="$2"
    
    if eval "$cmd" > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $desc"
    else
        echo -e "${RED}✗${NC} $desc"
        ERRORS=$((ERRORS + 1))
    fi
}

# Check required files exist
echo "📁 Checking file structure..."
check "README.md exists" "test -f README.md"
check "terraform/main.tf exists" "test -f terraform/main.tf"
check "terraform/variables.tf exists" "test -f terraform/variables.tf"
check "terraform/outputs.tf exists" "test -f terraform/outputs.tf"
check "docs/threat-model.md exists" "test -f docs/threat-model.md"
check "docs/controls-mapping.md exists" "test -f docs/controls-mapping.md"
check ".github/workflows/ci.yml exists" "test -f .github/workflows/ci.yml"

echo ""

# Check Terraform formatting
echo "🔧 Checking Terraform formatting..."
if command -v terraform &> /dev/null; then
    check "Terraform files formatted" "terraform fmt -check terraform/"
else
    echo "⚠️  Terraform not installed, skipping format check"
fi

echo ""

# Check for security issues in Terraform
echo "🔒 Checking security patterns..."
check "No hardcoded secrets in main.tf" "! grep -q 'password\s*=' terraform/main.tf"
check "No hardcoded API keys" "! grep -qE '(api_key|apikey)\s*=' terraform/main.tf"
check "Encryption enabled by default" "grep -q 'enable_encryption.*true' terraform/variables.tf"

echo ""

# Summary
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ $ERRORS check(s) failed${NC}"
    exit 1
fi
