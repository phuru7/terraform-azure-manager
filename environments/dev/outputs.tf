output "vm_info" {
  description = "Information about all VMs"
  value = {
    for name, vm in module.vm : name => {
      private_ip   = vm.private_ip_address
      principal_id = vm.principal_id
    }
  }
}

output "network_info" {
  description = "Network information"
  value       = module.network
}