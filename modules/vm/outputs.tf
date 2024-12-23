output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "private_ip_address" {
  description = "Private IP address of the VM"
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "principal_id" {
  description = "Principal ID of the system assigned identity"
  value       = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}