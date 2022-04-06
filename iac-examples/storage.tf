resource "azurerm_storage_account" "storage_acount" {
  name                     = "storageAccountName"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_account_container" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}