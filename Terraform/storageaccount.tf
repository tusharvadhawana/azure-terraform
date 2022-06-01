# Author: Tushar Vadhawana{tushar.vadhawana@t-systems.com}#

## Create Storage Account ##
resource "azurerm_storage_account" "terraform" {
    name = "terraformtest01tushar"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    account_tier = "Standard"
    account_replication_type = "LRS"
}
