variable "tenant_id" {
    type        = string
    #sensitive   = true # prepped for future use in Terraform 0.14
}
variable "subscription_id" {
    type        = string
    #sensitive   = true
}

variable "client_id" {
    type        = string
    #sensitive   = true
}

variable "client_secret" {
    type        = string
    #sensitive   = true
}