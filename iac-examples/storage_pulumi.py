import pulumi
import pulumi_azure as azure

storage_acount = azure.storage.Account("storageAcount",
    resource_group_name=azurerm_resource_group["example"]["name"],
    location=azurerm_resource_group["example"]["location"],
    account_tier="Standard",
    account_replication_type="LRS")
storage_account_container = azure.storage.Container("storageAccountContainer",
    storage_account_name=azurerm_storage_account["example"]["name"],
    container_access_type="private")