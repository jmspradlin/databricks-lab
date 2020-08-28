variable "rg_name" {
    default = "data-lake-rg01"
}
variable "rg_location" {
    default = "eastus2"
}
variable "account_kind" {
    default = "StorageV2"
}
variable "account_tier" {
    default = "Standard"
}
variable "storage_replication" {
    default = "LRS"
}
variable "databricks_sku" {
    default = "standard"
}