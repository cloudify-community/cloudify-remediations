terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>2.0"
        }
    }
}

provider "azurerm" {
   features {}
   subscription_id     = var.subscription_id
   tenant_id         = var.tenant_id
   client_id         = var.client_id
   client_secret     = var.client_secret
}

resource "azurerm_virtual_machine" "vm" {
  name = var.name
  vm_size = var.vm_size
  location = var.location
  network_interface_ids = []
  resource_group_name = var.resource_group
  storage_os_disk {
    name = ""
    create_option = ""
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to profiles/disks/identity/...
      os_profile, storage_os_disk, storage_data_disk, storage_image_reference,
      identity, os_profile_linux_config, boot_diagnostics, network_interface_ids,
      primary_network_interface_id, delete_data_disks_on_termination,
      delete_os_disk_on_termination, os_profile_windows_config

    ]
  }
}
