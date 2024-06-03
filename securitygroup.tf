resource "azurerm_network_security_group" "nsg_frontend" {
  name                = "nsg-frontend"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }
  # New security rule for ICMP (Ping)

  security_rule {
    name                       = "AllowPing"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.allowed_ip
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "frontend_association" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.nsg_frontend.id
}


######################  Backend  ############################

resource "azurerm_network_security_group" "nsg_backend" {
  name                = "nsg-backend"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


  security_rule {
    name                       = "AllowSSH-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = azurerm_public_ip.public_ip.ip_address
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH-outbound"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = azurerm_public_ip.public_ip.ip_address
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "backend_association" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.nsg_backend.id
}


###########################  DATABASE  #######################################
resource "azurerm_network_security_group" "nsg_database" {
  name                = "nsg-database"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "db-inbound-backend"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = azurerm_network_interface.nic_backend.ip_configuration[0].private_ip_address
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "3306"
  }

  security_rule {
    name                       = "db-outbound-Backend"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = azurerm_network_interface.nic_backend.ip_configuration[0].private_ip_address
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "3306"
  }

  security_rule {
    name                       = "db-frontend"
    priority                   = 102
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_address_prefix      = azurerm_public_ip.public_ip.ip_address
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "3306"
  }
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
  subnet_id                 = azurerm_subnet.database.id
  network_security_group_id = azurerm_network_security_group.nsg_database.id
}
