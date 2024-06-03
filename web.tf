resource "azurerm_resource_group" "rg" {
  name     = "three-tier-rg"
  location = "Central India"
}

#VMs for frontend & Backend and DB 
resource "azurerm_linux_virtual_machine" "frontend" {
  name                = "frontend-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_DS1_v2"
  admin_username      = "azureuser"

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub") # Adjust the path to your public key
  }

  network_interface_ids = [azurerm_network_interface.nic_frontend.id]

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

  #  provisioner "local-exec" {
  #    command = <<EOT
  #      ansible-playbook -i '${azurerm_public_ip.public_ip.ip_address},' -u azureuser --private-key ~/.ssh/id_rsa /Users/vikasupadhyaya/Desktop/Learn24/example_single/ansible/front.yaml
  #    EOT
  #  }  

}

resource "azurerm_public_ip" "public_ip" {
  name                = "frontend-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"

  tags = {
    environment = "frontend"
  }
}