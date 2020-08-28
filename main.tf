provider "azurerm" {
    version = "2.25.0"
    features {}
    
    skip_provider_registration = true
}

# Random ID generation
resource "random_id" "random" {
  byte_length = 3
}

resource "random_password" "sql_admin_pwd" {
  length            = 32
  special           = false
}

resource "azurerm_resource_group" "rg" {
    name        = var.rg_name
    location    = var.rg_location
}

resource "azurerm_storage_account" "dlstorage" {
  name        = random_id.random.dec
  location    = azurerm_resource_group.rg.location
  
  resource_group_name = azurerm_resource_group.rg.name

  account_kind    = var.account_kind
  account_tier    = var.account_tier
  is_hns_enabled  = true

  account_replication_type = var.storage_replication
}

resource "azurerm_databricks_workspace" "databricks01" {
  name      = "databricks${random_id.random.dec}"
  location  = azurerm_resource_group.rg.location
  
  resource_group_name = azurerm_resource_group.rg.name

  sku   = var.databricks_sku
}