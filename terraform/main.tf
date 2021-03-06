provider "azurerm" {
    version = "2.39.0"
    features {}
    
    # context
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    client_id       = var.client_id
    client_secret   = var.client_secret

    skip_provider_registration = true
}

terraform {
  backend "azurerm" {
    container_name        = "tfstate"
    key                   = "nonprod.databricks.tfstate"
  }
}   

# Random ID generation
resource "random_id" "random" {
  byte_length = 3
}

# Resource group creation
resource "azurerm_resource_group" "rg" {
    name        = "${random_id.random.dec}-${var.rg_name}"
    location    = var.rg_location
}

# Resources
resource "azurerm_storage_account" "dlstorage" {
  name                      = random_id.random.dec
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.storage_replication
  
  min_tls_version           = "TLS1_2"
  allow_blob_public_access  = false
  is_hns_enabled            = true
  enable_https_traffic_only = true
}

resource "azurerm_databricks_workspace" "databricks01" {
  name                = "databricks${random_id.random.dec}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.databricks_sku
}