resource "azurerm_linux_virtual_machine" "backend" {
  name                            = "backend-vm"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "123456Arc"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic_backend.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  #  admin_ssh_key {
  #    username   = "adminuser"
  #    public_key = "ssh-rsa YOUR_SSH_PUBLIC_KEY"
  #  }
}