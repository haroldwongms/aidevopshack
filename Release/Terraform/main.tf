locals {
  
}

provider "azuread" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
 
  subscription_id = "${var.ARM_SUBSCRIPTION_ID}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.ARM_CLIENT_SECRET}"
  tenant_id       = "${var.ARM_TENANT_ID}"
}

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
 
  subscription_id = "${var.ARM_SUBSCRIPTION_ID}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.ARM_CLIENT_SECRET}"
  tenant_id       = "${var.ARM_TENANT_ID}"
}

resource "azurerm_resource_group" "example" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}



resource "random_string" "password" {
  length = 32
  special = false
  keepers = {
    prefix = "${var.resource_group_name}"
  }
}

resource "azuread_application" "example" {
  name = "${var.prefix}-azureadapp"
  # homepage = "https://terra.from"
  # identifier_uris = ["https://terra.from"]
  # reply_urls = ["https://terra.from"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false
}

resource "azuread_service_principal" "example" {
  application_id = "${azuread_application.example.application_id}"
}

resource "azuread_service_principal_password" "example" {
  service_principal_id = "${azuread_service_principal.example.id}"
  value = "${random_string.password.result}"
  end_date = "2020-01-01T01:02:03Z"
}


resource "azurerm_kubernetes_cluster" "example" {
  name = "${var.prefix}-aks"
  location = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  dns_prefix = "${var.prefix}-aks"
  agent_pool_profile {
    name = "default"
    count = "${var.agent_count}"
    vm_size = "${var.vm_size}"
    os_type = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id = "${var.ARM_CLIENT_ID}"
    client_secret = "${var.ARM_CLIENT_SECRET}"
  }

  tags = {
    Environment = "Production"
  }
}


resource "azurerm_container_registry" "acr" {
  name                     = "${var.prefix}containerregistry"
  resource_group_name      = "${azurerm_resource_group.example.name}"
  location                 = "${azurerm_resource_group.example.location}"
  sku                      = "Basic"
  admin_enabled            = false
}