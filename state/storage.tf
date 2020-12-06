# Provider block for AzureRm
provider "azurerm" {
    version = "~>2.39.0"
    features {}
    
    #
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    client_id       = var.client_id
    client_secret   = var.client_secret
    
    skip_provider_registration = true
}

# Random ID generation
resource "random_id" "random" {
  byte_length = 2
}

resource "azurerm_resource_group" "rg" {
    name        = "tfstate-${random_id.random.dec}"
    location    = "eastus2"
}

resource "azurerm_storage_account" "tfstate" {
    name                = "tfstate${random_id.random.dec}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    
    account_tier                = "Standard"
    account_replication_type    = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}