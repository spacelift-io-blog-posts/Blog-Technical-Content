provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.95.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf-rg"
    storage_account_name = "jacktfstatesa"
    container_name       = "terraform"
    key                  = "adgroups.tfstate"
  }
}

module "ad_group" {
  source         = "./ad_group"
  ad_group_names = var.ad_group_names
}