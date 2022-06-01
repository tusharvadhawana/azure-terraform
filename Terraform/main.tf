terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
  }
}


## Create Resource Group ##
resource "azurerm_resource_group" "rg" {
  name     = "Terraform-Test"
  location = var.location
}

## Create VNET ##
resource "azurerm_virtual_network" "vnet" {
    name = "terraform-vnet"
    address_space = ["10.10.10.0/24"]
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
}

## Create Subnetes ##
resource "azurerm_subnet" "subnet" {
    for_each = var.subnet
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    name = each.value["name"]
    address_prefixes = each.value["address_prefixes"]
}

## Create Postgres NSG ##
resource "azurerm_network_security_group" "postgres_nsg" {
    name = "postgres"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    security_rule {
        name = "SSH"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
}

## Create Network Interface ##
resource "azurerm_network_interface" "nic" {
  name                = "postgres-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
 
   ip_configuration {
    name                          = "postgres-01"
    subnet_id                     = azurerm_subnet.subnet["subnet_2"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.db1_pip.id
  }
}

## NSG associate with NIC ##
resource "azurerm_network_interface_security_group_association" "dbnsg" {
    network_interface_id = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.postgres_nsg.id 
}
  
## Create Virtual Machine ##
