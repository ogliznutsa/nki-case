terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Local backend for POC; switch to Terraform Cloud
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}

provider "azuread" {}
