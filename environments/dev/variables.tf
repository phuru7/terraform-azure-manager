variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, sit, prod)"
}

variable "vm_configs" {
  description = "Configuration for virtual machines"
  type = map(object({
    instances = map(object({
      instance_number = string
      role            = string
    }))
    tier        = string
    subnet_name = string
  }))
}

variable "vm_size" {
  type        = string
  description = "VM size"
}

variable "os_disk_size" {
  type        = number
  description = "OS disk size in GB"
}