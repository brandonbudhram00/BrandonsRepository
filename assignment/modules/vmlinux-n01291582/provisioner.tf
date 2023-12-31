resource "null_resource" "linux_provisioner" {
  count      = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux_vm]

  connection {
    type        = "ssh"
    user        = var.admin_username
    private_key = file(var.linux_private_key)
    host        = element(azurerm_linux_virtual_machine.linux_vm[*].public_ip_address, count.index)

    # Ansible provisioner
    provisioner "remote-exec" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install -y ansible",
        "ansible-playbook -i localhost, /mnt/c/Users/Brand/desktop/Automation/terraform/assignment/ansible/n01291582-playbook.yaml",
      ]
    }
  }
}
