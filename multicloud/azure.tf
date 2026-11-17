# Azure side — verified/listed by api/cloud_azure.go (VMs + storage accounts).
resource "azurerm_virtual_machine" "worker" {
  name                  = "terrasuite-worker"
  location              = "eastus"
  resource_group_name   = "terrasuite-demo-rg"
  network_interface_ids = ["/subscriptions/00000000-0000-0000-0000-000000000001/resourceGroups/terrasuite-demo-rg/providers/Microsoft.Network/networkInterfaces/terrasuite-nic"]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "terrasuite-worker-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "terrasuite-worker"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
  }

  tags = {
    owner = "platform"
    tier  = "worker"
  }
}

resource "azurerm_storage_account" "audit" {
  name                     = "terrasuiteauditdemo"
  resource_group_name      = "terrasuite-demo-rg"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    owner = "platform"
    tier  = "audit"
  }
}
