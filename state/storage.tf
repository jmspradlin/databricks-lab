# Provider block for AzureRm
provider "azurerm" {
    version         = "~>2.39.0"
    features {}
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