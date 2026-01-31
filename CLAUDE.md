# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Azure B2B identity federation POC demonstrating external customer authentication using Azure Entra ID External Identities with Okta SAML federation for a Next.js Container App.

## Development Commands

### Application (from `/app`)

```bash
npm install          # Install dependencies
npm run dev          # Development server at http://localhost:3000
npm run build        # Production build
npm run lint         # ESLint checks
```

### Terraform (from `/terraform/environments/dev`)

```bash
terraform init       # Initialize providers
terraform validate   # Validate configuration
terraform plan       # Preview changes
terraform apply      # Apply infrastructure
terraform output     # View deployment outputs
```

### Docker (from `/app`)

```bash
docker build .       # Build container image
```

### Azure Verification

```bash
az containerapp show --name nki-app-dev --resource-group rg-nki-dev
az containerapp logs show --name nki-app-dev --resource-group rg-nki-dev --follow
```

## Architecture

### Infrastructure (Terraform)

Modular design in `terraform/modules/`:
- **resource-group** - Azure Resource Group
- **key-vault** - Secrets management (OAuth secrets, NextAuth secret)
- **container-app-environment** - Log Analytics + Container App Environment
- **container-registry** - ACR for Docker images
- **container-app** - Next.js runtime with Key Vault secret injection
- **app-registration** - Azure AD app with OAuth/SAML configuration
- **azuread-groups** - Security groups for RBAC

Environments orchestrate modules via `terraform/environments/{dev,prod}/main.tf`.

### Application (Next.js 16)

- **Authentication**: Auth.js v5 (next-auth 5.0) with Microsoft Entra ID provider (`app/src/lib/auth.ts`)
- **Auth handler**: `app/src/app/api/auth/[...nextauth]/route.ts` (exports Auth.js v5 handlers)
- **Login UI**: `app/src/components/LoginButton.tsx`
- **Containerization**: Multi-stage Dockerfile with Alpine base, runs as non-root user on port 3000

### Identity Flow

1. B2B: User → Okta SAML → Azure Entra ID → NextAuth.js → App
2. B2C: User → Azure AD direct → NextAuth.js → App

### CI/CD

GitHub Actions (`.github/workflows/app-deploy.yml`) triggers on `app/**` changes:
1. Build Docker image
2. Push to ACR with git SHA tag
3. Deploy to Azure Container App

## Key Configuration

- **Tenant ID**: `7092ede8-b740-4042-8d4d-d4aca9097462`
- **Okta Domain**: `integrator-5442588.okta.com`
- **Region**: `westeurope`
- **Subscription**: `3483adc4-e31e-463c-bceb-525235c5e778`

## Environment Variables (Container App)

Injected automatically by Terraform:
- `AZURE_AD_CLIENT_ID`, `AZURE_AD_CLIENT_SECRET`, `AZURE_AD_TENANT_ID`
- `NEXTAUTH_URL` (computed from FQDN), `NEXTAUTH_SECRET` (from Key Vault)

## Documentation

When making changes to the project, keep `README.md` in sync with any architectural, configuration, or usage changes.
