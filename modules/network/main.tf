resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.environment}-${var.location}-000"
  resource_group_name = var.resource_group_name
  location           = var.location
  address_space      = ["10.0.0.0/16"]
  tags               = var.tags
}

resource "azurerm_subnet" "subnets" {
  for_each = {
    app = "10.0.1.0/24"
    db  = "10.0.2.0/24"
    web = "10.0.3.0/24"
  }

  name                 = "snet-Swift${upper(each.key)}servers"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value]
}

resource "azurerm_key_vault" "main" {
  name                = "kv-${var.environment}-${var.location}-001"
  resource_group_name = var.resource_group_name
  location           = var.location
  tenant_id          = data.azurerm_client_config.current.tenant_id
  sku_name           = "standard"
  tags               = var.tags
}

resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&"
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  value        = random_password.vm_password.result
  key_vault_id = azurerm_key_vault.main.id
}