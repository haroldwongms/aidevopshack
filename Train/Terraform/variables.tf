
variable "location" {
    description = "Location of the resource group"
    default = "southcentralus"
}

variable "vm_size" {
    description = "Size of the VM"
    default = "Standard_D4_v2"
}

variable "prefix" {
    description = "String prefix"
    default = "aidevopshackraj"
}

variable "password" {
  description = "User password"
}

variable "ARM_SUBSCRIPTION_ID" {
  description = "The Azure subscription ID."
}

variable "ARM_CLIENT_ID" {
  description = "The Azure Service Principal app ID."
}

variable "ARM_CLIENT_SECRET" {
  description = "The Azure Service Principal password."
}

variable "ARM_TENANT_ID" {
  description = "The Azure Tenant ID."
}


variable "username" {
  description = "User name"

}