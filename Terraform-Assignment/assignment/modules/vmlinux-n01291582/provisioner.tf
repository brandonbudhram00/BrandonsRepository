resource "null_resource" "linux_provisioner" {
    count       = var.nb_count
    depends_on  = [azurerm_linux_virtual_machine.linux_vm]

        connection {
          type        = "ssh"
          user        = var.admin_username
          private_key = file(var.linux_private_key)
          host        = element(azurerm_linux_virtual_machine.linux_vm[*].public_ip_address, count.index + 1)

          provisioner "remote-exec" {
            inline = ["hostname"]
          }
        }
}