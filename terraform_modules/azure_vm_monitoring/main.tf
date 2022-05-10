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


resource "azurerm_log_analytics_workspace" "law" {
  name                      = "${var.name}-LogAnalyticsWorkspace"
  location                  = var.location
  resource_group_name       = var.resource_group
  sku                       = "PerGB2018"
  retention_in_days         = "30"
  internet_ingestion_enabled= true
  internet_query_enabled    = false
}

resource "azurerm_log_analytics_solution" "vminsights" {
  solution_name         = "VMInsights"
  location              = var.location
  resource_group_name   = var.resource_group
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }
}

resource "azurerm_virtual_machine_extension" "omsext" {
  name                  = "${var.name}-OMSExtension"
  virtual_machine_id    = azurerm_virtual_machine.vm.id
  publisher             = "Microsoft.EnterpriseCloud.Monitoring"
  type                  = azurerm_virtual_machine.vm.storage_os_disk[0].os_type=="Windows" ? "MicrosoftMonitoringAgent":"OmsAgentForLinux"
  type_handler_version  = "1.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "workspaceId": "${azurerm_log_analytics_workspace.law.workspace_id}"
    }
  SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${azurerm_log_analytics_workspace.law.primary_shared_key}"
    }
  PROTECTED_SETTINGS
  depends_on = [azurerm_virtual_machine.vm]
}

resource "azurerm_virtual_machine_extension" "DAAgent" {
  name                       = "DAAgentExtension"
  virtual_machine_id         = azurerm_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = azurerm_virtual_machine.vm.storage_os_disk[0].os_type=="Windows" ? "DependencyAgentWindows": "DependencyAgentLinux"
  type_handler_version       = "9.10"
  auto_upgrade_minor_version = true
  depends_on = [azurerm_virtual_machine.vm]
}
