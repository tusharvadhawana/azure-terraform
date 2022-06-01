output "subnet_id" {
  value = [ for x in azurerm_subnet.subnet : x.id]
}

output "nic_id" {
    value = azurerm_network_interface.nic.id 
}
output "postgres01_pub_ip" {
  value = azurerm_public_ip.db1_pip
  
}
