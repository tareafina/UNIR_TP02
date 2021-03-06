resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vm_name}"
  location              = "${var.location}"
  resource_group_name   = "${var.rg_name}"
  network_interface_ids = var.ni_id
  vm_size               = "${var.vm_size}"
  availability_set_id   = "${var.av_set_id}"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_3"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.os_disk_name}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"

  }

  storage_data_disk {
    name            = "${var.data_disk_name}"
    managed_disk_id = "${var.data_disk_id}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = 30
  }

  os_profile {
    computer_name  = "${var.vm_os_name}"
    admin_username = "${var.vm_os_user}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.vm_os_user}/.ssh/authorized_keys"
      key_data = file("${path.module}/keys/id_rsa.pub")
    }
  }

  tags = {
    "Environment" = "${var.env}"    
    "Project" = "${var.project_name}"
  }
}