variable "image" {
  description = "Talos image configuration"
  type = object({
    factory_url       = optional(string, "https://factory.talos.dev")
    schematic         = string
    version           = string
    update_schematic  = optional(string)
    update_version    = optional(string)
    arch              = optional(string, "amd64")
    platform          = optional(string, "nocloud")
    proxmox_node      = optional(string, "pve-01")
    proxmox_datastore = optional(string, "nfs-shared")
  })
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name               = string
    endpoint           = string
    gateway            = string
    vip                = string
    talos_version      = string
    proxmox_cluster    = string
    kubernetes_version = optional(string, "1.32.0")
  })
}


variable "nodes" {
  description = "Configuration for cluster nodes"
  type = map(object({
    proxmox_node     = string
    controller       = bool
    allow_scheduling = optional(bool, false)
    datastore_id     = optional(string, "local-lvm")
    ip               = string
    mac_address      = string
    vm_id            = number
    cpu              = number
    ram_dedicated    = number
    update           = optional(bool, false)
    igpu             = optional(bool, false)
    disks = optional(map(object({
      device     = string
      size       = string
      type       = string
      mountpoint = string
    })), {})
  }))
}

# variable "storage_pool" {
#   type        = string
#   description = "Default Proxmox storage pool to use for VM disks."
# }

# variable "disk_owner" {
#   description = "Where to create the data disks VM"
#   type = object({
#     node_name = string
#     vm_id     = number
#   })
# }
variable "inline_manifests" {
  description = "Inline manifests to apply after bootstrap with dependencies"
  type = list(object({
    name         = string
    content      = string
    dependencies = optional(list(string), [])
  }))
  default = []
}


