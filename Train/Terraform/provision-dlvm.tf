locals {
  number_of_disks = 1
}

resource "azurerm_virtual_machine" "example" {
  name                  = "${var.prefix}-vm"
  location              = "${azurerm_resource_group.example.location}"
  resource_group_name   = "${azurerm_resource_group.example.name}"
  network_interface_ids = ["${azurerm_network_interface.example.id}"]
  vm_size               = "Standard_NC6"

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  plan {
    name = "linuxdsvmubuntu"
    publisher = "microsoft-ads"
    product = "linux-data-science-vm-ubuntu"
  }
  storage_image_reference {
    publisher = "microsoft-ads"
    offer     = "linux-data-science-vm-ubuntu"
    sku       = "linuxdsvmubuntu"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "dlvm"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
    
  }
}

resource "azurerm_managed_disk" "external" {
  count                = "${local.number_of_disks}"
  name                 = "${var.prefix}-disk${count.index+1}"
  location             = "${azurerm_resource_group.example.location}"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
}

resource "azurerm_virtual_machine_data_disk_attachment" "external" {
  count              = "${local.number_of_disks}"
  managed_disk_id    = "${azurerm_managed_disk.external.*.id[count.index]}"
  virtual_machine_id = "${azurerm_virtual_machine.example.id}"
  lun                = "${10+count.index}"
  caching            = "ReadWrite"
}
