output "pub_ip_id" {
  value = azurerm_public_ip.pub_ip.id
}

output "ip_address" {
  value = azurerm_public_ip.pub_ip.ip_address
}

output "fqdn" {
  value = azurerm_public_ip.pub_ip.fqdn
}