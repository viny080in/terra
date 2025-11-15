##########################################################
# Terraform to create Azure RG and VNet (free resources)
# Region: South India
# Cost: ₹0 under Pay-as-you-Go (no paid compute/storage)
##########################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Optionally specify subscription if multiple are configured:
  # subscription_id = "<your-subscription-id>"
}

# --------------------------
# Resource Group
# --------------------------
resource "azurerm_resource_group" "rg" {
  name     = "Viny-RG-IND-01"
  location = "South India"

  tags = {
    Environment = "FreeTier"
    Owner       = "Viny"
    CostCenter  = "ZeroCost"
  }
}

# --------------------------
# Virtual Network
# --------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "Vnet-IND-01"
  address_space       = ["172.100.10.0/27"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Environment = "FreeTier"
    Owner       = "Viny"
  }
}
// end