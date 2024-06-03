/*
// Create a local file containing the static inventory
resource "local_file" "ansible_inventory" {
  filename = "inventory"
  content = <<-EOT
[frontend]
${azurerm_public_ip.public_ip.ip_address}

[backend]
${join("\n", azurerm_network_interface.nic_backend[*].private_ip_address)}
  EOT
}

resource "null_resource" "ansible" {
  # Trigger Ansible playbook execution on frontend and backend VMs

  triggers = {
    frontend_id = azurerm_linux_virtual_machine.frontend.id
    backend_id  = azurerm_linux_virtual_machine.backend.id
  }

  provisioner "local-exec" {
    command = <<EOF
      ansible-playbook -i inventory initial_playbook.yml --limit frontend
    EOF
  }
}
*/