variable "subscription_id" {
  type = string
  description = "Azure subscription ID"
}

variable "tenant_id" {
  type = string
  description = "Azure Tenant ID"
}

variable "client_id" {
  type = string
  description = "Azure client (application) ID"
}

variable "client_secret" {
  type = string
  description = "Azure client (application) secret"
}

variable "resource_group" {
  type = string
  description = "Azure resource_group"
}

variable "location" {
  type = string
  description = "Azure location"
}

variable "name" {
  type = string
  description = "vm name"
}

variable "vm_size" {
  type = string
  description = "vm instance size"
}
