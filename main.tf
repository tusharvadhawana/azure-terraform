terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend"
    storage_account_name = "terraformbackendtushar"
    container_name       = "terraform-state-file"
    key                  = "terraformgit.tfstate"
  }
}

terraform {
  required_version = ">= 1.1" 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
  }
  
}


#Create Resource Group
resource "azurerm_resource_group" "Tushar" {
  name     = "Terraform-Action"
  location = "northeurope"
}
