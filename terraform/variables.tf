variable "tenant_id" {
    type        = string
    sensitive   = true # used only in Terraform ver. => 0.14
}
variable "subscription_id" {
    type        = string
    sensitive   = true
}

variable "client_id" {
    type        = string
    sensitive   = true
}

variable "client_secret" {
    type        = string
    sensitive   = true
}

variable "rg_name" {
    type    = string
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