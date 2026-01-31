# NKI B2B Identity Federation POC

Azure B2B identity federation proof-of-concept: external customers authenticate via their corporate Okta, federated through Azure Entra ID External Identities, into a Next.js Container App.

## What Was Built

**Problem**: NKI's first B2B pilot customer needs their employees to access our app using their existing Okta identity provider, without creating separate accounts.

**Solution**: SAML federation between Okta and Azure Entra ID External Identities, enabling seamless SSO for external users.

### Architecture

```
User (Okta) → Next.js App → Azure Entra ID → Okta SAML IdP → Back to App (authenticated)
```

### Components

**Infrastructure (Terraform)**:
- `resource-group` - Azure Resource Group
- `key-vault` - Secrets (OAuth credentials, NextAuth secret)
- `container-app-environment` - Log Analytics + Container App Environment
- `container-registry` - ACR for Docker images
- `container-app` - Next.js runtime with Key Vault secret injection
- `app-registration` - Azure AD app with OAuth configuration
- `azuread-groups` - Security groups for RBAC

**Application**:
- Next.js 16 with Auth.js v5 (next-auth 5.0) Microsoft Entra ID provider
- Multi-stage Docker build, deployed to Azure Container Apps

**CI/CD**:
- GitHub Actions workflow for automated deployments on code changes

## What's Missing for Production

| Missing | Why Left Out |
|---------|--------------|
| **Disable ACR Admin Credentials** | Container App uses managed identity for pull but admin still needed for GitHub Actions push (blocked by OIDC item below) |
| **OIDC Workload Identity for GitHub Actions** | Currently uses service principal credentials; production should use federated identity (OIDC) to eliminate stored secrets |
| **VNet Integration** | Would place Container App in private network with private endpoints for Key Vault/ACR - overkill for demo |
| **Custom Domain + SSL** | Default Azure domain sufficient for POC |
| **Application Insights** | Monitoring not critical for demo |
| **Terraform Remote State** | Local state acceptable for single-developer POC |
| **Production Environment** | Only dev deployed; prod is a stub |
| **SAML IdP via Terraform** | Azure doesn't support via API - requires portal |
| **Terraform in CI/CD** | Main workflow should run `terraform apply` (with manual approval for prod) |
| **PR Workflow** | Should run linters, unit tests, `terraform plan` on pull requests |
| **Client Secret Rotation** | Azure AD client secrets expire; production needs automated rotation via Terraform `time_rotating` resource |

## LLM Usage

This project was built with Claude Code assistance.

**What AI helped with**:
- Terraform module structure and Azure resource configuration
- NextAuth.js integration patterns with Azure AD
- Docker multi-stage build optimization
- Documentation and troubleshooting guides
- SAML configuration parameters research

**What required human work**:
- Azure portal: SAML IdP configuration (not Terraform-supported)
- Okta developer account setup and SAML app configuration
- Architecture decisions and trade-offs
- Testing and validation of auth flows
- Business requirements interpretation

## Quick Start

### Test the deployed app

1. Open: `https://nki-app-dev.nicebeach-b084e480.westeurope.azurecontainerapps.io`
2. Click "Sign in with Azure AD"
3. Enter `testuser@integrator-5442588.okta.com` / `wyHmo5-zahpur-pyfgyv` for B2B flow (Okta federation)
4. Or use any `@streamscloud.com` user for B2C flow (direct Azure AD)
