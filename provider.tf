terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.92.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstates"
    storage_account_name = "pmstates"
    container_name       = "tofu-azure-cr"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
