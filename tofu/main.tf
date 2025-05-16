module "talos" {
  source = "./talos"

  providers = {
    proxmox = proxmox
  }

  # disk_owner = var.disk_owner
  # storage_pool = var.storage_pool


  image = {
    version        = "v1.10.1"
    update_version = "v1.10.1" # renovate: github-releases=siderolabs/talos
    schematic      = file("${path.module}/talos/image/schematic.yaml")
  }

  cluster = {
    name               = "talos"
    endpoint           = "api.kube.mrmm.xyz"
    gateway            = "192.168.1.254" # Network gateway
    vip                = "192.168.1.55"  # Control plane VIP
    talos_version      = "v1.9.5"
    proxmox_cluster    = "kube"
    kubernetes_version = "1.33.0" # renovate: github-releases=kubernetes/kubernetes
  }

  nodes = {
    "ctrl-01" = {
      proxmox_node     = "pve-01"
      controller       = true
      ip               = "192.168.1.60"
      mac_address      = "bc:24:11:e6:ba:07"
      vm_id            = 8101
      cpu              = 4
      ram_dedicated    = 1024 * 4
      update           = false
      igpu             = false
      allow_scheduling = false
    }
    "ctrl-02" = {
      proxmox_node     = "pve-02"
      controller       = true
      ip               = "192.168.1.61"
      mac_address      = "bc:24:11:44:94:5c"
      vm_id            = 8102
      cpu              = 4
      ram_dedicated    = 1024 * 4
      update           = false
      igpu             = false
      allow_scheduling = false
    }
    "ctrl-03" = {
      proxmox_node     = "pve-03"
      controller       = true
      ip               = "192.168.1.62"
      mac_address      = "bc:24:11:1e:1d:2f"
      vm_id            = 8103
      cpu              = 4
      ram_dedicated    = 1024 * 4
      update           = false
      allow_scheduling = false
    }
    "work-01" = {
      proxmox_node  = "pve-01"
      controller    = false
      ip            = "192.168.1.71"
      mac_address   = "bc:24:11:64:5b:cb"
      vm_id         = 8201
      cpu           = 6
      ram_dedicated = 1024 * 10
      update        = false
      disks = {
        longhorn = {
          device     = "/dev/sdb"
          size       = "180G"
          type       = "scsi"
          mountpoint = "/var/lib/longhorn"
        }
      }
    }
    "work-02" = {
      proxmox_node  = "pve-02"
      controller    = false
      ip            = "192.168.1.72"
      mac_address   = "bc:24:11:c9:22:c3"
      vm_id         = 8202
      cpu           = 4
      ram_dedicated = 1024 * 16
      update        = false
      disks = {
        longhorn = {
          device     = "/dev/sdb"
          size       = "180G"
          type       = "scsi"
          mountpoint = "/var/lib/longhorn"
        }
      }
    }
    "work-03" = {
      proxmox_node  = "pve-03"
      controller    = false
      ip            = "192.168.1.73"
      mac_address   = "bc:24:11:6f:20:03"
      vm_id         = 8203
      cpu           = 4
      ram_dedicated = 1024 * 16
      update        = false
      disks = {
        longhorn = {
          device     = "/dev/sdb"
          size       = "180G"
          type       = "scsi"
          mountpoint = "/var/lib/longhorn"
        }
      }
    }
  }
}

