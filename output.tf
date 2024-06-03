output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "frontend_ip_private" {
  value = azurerm_network_interface.nic_frontend[*].private_ip_address
}

output "backend_ip_private" {
  value = azurerm_network_interface.nic_backend[*].private_ip_address
}

output "frontend_ip_public" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "remote_user" {
  value = azurerm_linux_virtual_machine.frontend.admin_username
}

output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.db.fqdn
}