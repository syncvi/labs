
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

locals {
  resource_group_name = "demo-grp"
  location            = "Central India"
  virt_ntwrk = {
    name          = "example-network"
    address_space = ["10.0.0.0/16"]
  }
}
resource "azurerm_resource_group" "demogrp" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "demovirnet" {
  name                = local.virt_ntwrk.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = local.virt_ntwrk.address_space

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
