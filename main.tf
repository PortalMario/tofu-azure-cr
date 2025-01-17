resource "azurerm_resource_group" "resource_group" {
    name = "azure-cr"
    location = "westeurope"
}


locals {
  container_registries = yamldecode(file("${path.module}/inputs.yaml"))

  # why cant i only use  { for registry in local.container_registries : registry.name => registry }
  container_registries_map = {for registry in local.container_registries : "registries" => {for reg in registry : reg.name => reg }}
  
}

resource "azurerm_container_registry" "cr" {
    for_each = local.container_registries_map.registries

    name = each.key
    resource_group_name = azurerm_resource_group.resource_group.name
    location = azurerm_resource_group.resource_group.location
    #public_network_access_enabled = false  # not in basic tier
    sku = "Basic"
}