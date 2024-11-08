
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
  local_interface_name = "demo-iface"
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

  depends_on = [azurerm_resource_group.demogrp]
}

resource "azurerm_subnet" "subnetA" {
  name                 = "subnetA"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.demovirnet.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on           = [azurerm_virtual_network.demovirnet]
}

resource "azurerm_subnet" "subnetB" {
  name                 = "subnetB"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.demovirnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [azurerm_virtual_network.demovirnet]
}

resource "azurerm_network_interface" "demo-interface" {
  name                = local.local_interface_name
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [azurerm_subnet.subnetA]
}

output "subnetA-id" {
  value = azurerm_subnet.subnetA.id
}
