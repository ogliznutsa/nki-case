# Senior Platform Engineer – Take-Home Task

**Submission:** GitHub repo + slides, at least 2 hours before discussion round

---

## The Scenario

NKI is onboarding its first B2B pilot customer. Their employees need to access our Next.js app deployed as an Azure Container App, using their company's existing identity provider (Okta). We have Entra AD with external identities in place that the Okta should be integration though. 

You've been asked to:
1. Design and prototype the identity federation setup
2. Present the approach to our semi-technical audience
---

## Part 1: Technical Implementation

Create a GitHub repository containing:

### Terraform Configuration
Provision the Azure infrastructure needed for B2B identity federation:
- Azure AD B2B / External Identities configuration
- Container APP (some mock application)
- App registration for the application
- Appropriate RBAC and security groups
- Any supporting infrastructure (Key Vault for secrets, etc.)
- We have dev and prod environments
- We use Github Actions for CI/CD


### Documentation
A README covering:
- What you built and why
- What's missing for production (and why you left it out)
- How you used LLM tools during this task

---

## Part 2: Stakeholder Presentation

Create a short presentation (3-5 slides) aimed at our CEO and CDO explaining:

1. **What problem we're solving** – why do B2B customers need this?
2. **How it works** – in terms a non-technical executive can understand
3. **What we're building** – high-level architecture (one simple diagram)
4. **Timeline and risks** – what could go wrong, what dependencies exist
5. **What you need from leadership** – decisions, resources, access

The goal: Could our CEO read this and confidently explain the approach to a board member or customer?

---

## Context You'll Need

**Our current stack:**
- Azure (Container Apps, PostgreSQL, Key Vault, Entra ID)
- Terraform + GitHub Actions for IaC/CI-CD

**Asumtionts**
- e2e Demo is welcome, but it is also fine to deliver the parts that do not work e2e and explain what is left for you to do to make it work
- this is a proof-of-concept, not production. Show us how you'd structure it, not every possible edge case.

---

## Submission Checklist

- [ ] GitHub repo (public or private with collaborators added)
 - [ ] Terraform configuration
 - [ ] CI/CD setup
 - [ ] README with design decisions and AI usage reflection
- [ ] Presentation slides (3-5 slides)
 - [ ] Problem framing
 - [ ] Non-technical explanation
 - [ ] Architecture diagram
 - [ ] Timeline/risks
 - [ ] Asks from leadership

---

## What Happens Next

In the discussion round (90 min), we'll:
1. Have you present the slides as if to our actual leadership (30 min)
2. Ask you around the strategy, probe some use-cases (15 min)
2. Walk through your Terraform and ask you to explain it (30 min)
3. Probe your technical depth with some additional questions (15 min)

## Context
This is a simplified real problem, something that we're tacking now. Today, we have support for B2C-setup with approximately 2.5-3k users, using Entra AD where users gets new @edu emails as internal users in our org. The architecture needs to be restructured to also support B2B, go away from @edu and internal users for B2C, and we need a solution that can handle both B2B and B2C, that can log them in with their original emails.