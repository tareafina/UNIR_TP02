output "ni_id" {
  value = azurerm_network_interface.ni.id
}

output "private_ip_address" {
    value = azurerm_network_interface.ni.private_ip_address
}