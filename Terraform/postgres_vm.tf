resource "azurerm_linux_virtual_machine" "postgres-01" {
    name = "postgres01"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    size = var.postgres_size
    network_interface_ids = [azurerm_network_interface.nic.id]
    computer_name = "postgres01"
    admin_username = "azureuser"
    admin_password = "Admin123"
    disable_password_authentication = false

    os_disk {
      name = "postgres_os_disk"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-focal"
      sku = "20_04-lts-gen2"
      version = "latest"
    }
}
resource "azurerm_managed_disk" "db01" {
    name = "db01"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    storage_account_type = "Standard_LRS"
    create_option = "Empty"
    disk_size_gb = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "attachdb01" {
    managed_disk_id = azurerm_managed_disk.db01.id
    virtual_machine_id = azurerm_linux_virtual_machine.postgres-01.id
    lun = "1"
    caching = "ReadWrite" 
    depends_on = [
      azurerm_linux_virtual_machine.postgres-01
    ]
}
