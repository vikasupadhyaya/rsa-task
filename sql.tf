resource "azurerm_mysql_flexible_server" "db" {
  name                   = "mysql11-flexible-server"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = "mysqladminun"
  administrator_password = var.mysql_password
  sku_name               = "B_Standard_B1s"
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = "database"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_backend_ip" {
  name                = "allow-backend-ip"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db.name
  start_ip_address    = azurerm_network_interface.nic_backend.ip_configuration[0].private_ip_address
  end_ip_address      = azurerm_network_interface.nic_backend.ip_configuration[0].private_ip_address
}