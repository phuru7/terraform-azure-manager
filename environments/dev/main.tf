provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = true
      skip_shutdown_and_force_delete = false
    }
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

locals {
  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "phuru"
    created_at  = timestamp()
  }
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = var.location
  environment         = var.environment
  tags                = local.common_tags
}

module "vm" {
  source = "../../modules/vm"

  for_each = merge([
    for tier, config in var.vm_configs : {
      for name, instance in config.instances : name => {
        tier        = config.tier
        subnet_name = config.subnet_name
        role        = instance.role
      }
    }
  ]...)

  name                = each.key
  resource_group_name = data.azurerm_resource_group.main.name
  location            = var.location
  subnet_id           = module.network.subnet_ids[each.value.tier]
  vm_size             = var.vm_size
  admin_password      = module.network.key_vault_secret_value
  os_disk_size        = var.os_disk_size
  tier                = each.value.tier

  tags = merge(local.common_tags, {
    tier = each.value.tier
    role = each.value.role
  })
}