variable "resource_group_name" {
    description = "Existing resource group name to host AKS cluster"
    default = "aidevopshack"
}

variable "location" {
    description = "Location of the resource group"
    default = "centralus"
}

variable "vm_size" {
    description = "Size of the VM"
    default = "Standard_D4_v2"
}

variable "prefix" {
    description = "String prefix"
    default = "aidevopshack"
}
variable "agent_count" {
    description = "Number of VM agents nodes."
    default = "3"
}

variable "log_analytics_sku" {
    description = "SKU of the log analytics workspace."
    default = "PerGB2018"
}

variable "log_analytics_retention_days" {
    description = "Log analytics workspace retention days."
    default = "30"
}



