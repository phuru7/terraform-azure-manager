variable "name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the VM"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the VM will be deployed"
}

variable "vm_size" {
  type        = string
  description = "Size of the VM"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Password for the VM admin user"
}

variable "os_disk_size" {
  type        = number
  description = "Size of the OS disk in GB"
}

variable "tier" {
  type        = string
  description = "Tier of the VM (app, db, web)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}