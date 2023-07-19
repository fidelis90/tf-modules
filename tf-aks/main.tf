resource "azurerm_resource_group" "k8s" {
  location = var.location
  name     = var.resource_group_name # convention per the document #TODO: tony pull up the doc
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_cidr #CIDR BLOCK PER DOCUMENT () #TODO: TONY get a link

}

resource "azurerm_subnet" "subnet" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.k8s.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.subnet_cidr
  depends_on = [azurerm_virtual_network.vnet, azurerm_resource_group.k8s]
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  location            = coalesce(var.location, azurerm_resource_group.k8s.location)
  # The WorkSpace name has to be unique across the whole of azure;
  # not just the current subscription/tenant.
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  resource_group_name = azurerm_resource_group.k8s.name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "test" {
  location            = coalesce(var.location, azurerm_resource_group.k8s.location)
  resource_group_name   = azurerm_resource_group.k8s.name #azurerm_resource_group.k8s.name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.log_analytics_workspace.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = coalesce(var.location, azurerm_resource_group.k8s.location)
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = var.dns_prefix
  tags                = var.aks_cluster_resource_tags

  default_node_pool {
    name       = var.agents_pool_name
    vm_size    = var.agents_size
    node_count = var.agents_count
    vnet_subnet_id     = azurerm_subnet.subnet.id

  }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = "standard"

  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_virtual_network.vnet]
}