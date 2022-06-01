# Create public IPs
resource "azurerm_public_ip" "db1_pip" {
    name = "postgres_pip"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Dynamic"
 
}