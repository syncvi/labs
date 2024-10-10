
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.2.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "123"
  features {

  }
}

resource "azurerm_resource_group" "demogrp" {
  name     = "demo-grp"
  location = "Central India"
}

resource "azurerm_virtual_network" "demovirnet" {
  name                = "example-network"
  location            = azurerm_resource_group.demogrp.location
  resource_group_name = azurerm_resource_group.demogrp.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "subnetA"
    address_prefixes = ["10.0.0.0/24"]
  }

  subnet {
    name             = "subnetB"
    address_prefixes = ["10.0.1.0/24"]
  }

  depends_on = [azurerm_resource_group.demogrp]
}
