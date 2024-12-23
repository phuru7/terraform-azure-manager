output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value = {
    for k, v in azurerm_subnet.subnets : k => v.id
  }
}

output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.main.id
}

output "key_vault_secret_value" {
  description = "VM admin password"
  value       = azurerm_key_vault_secret.vm_password.value
  sensitive   = true
}