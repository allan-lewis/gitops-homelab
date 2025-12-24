terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.90.0"

      # Tell Terraform this module expects these provider aliases
      configuration_aliases = [
        proxmox.sirius,
        proxmox.polaris,
      ]
    }
  }
}

# VMs that should use the "sirius" alias
resource "proxmox_virtual_environment_vm" "vm_ubuntu_sirius" {
  provider = proxmox.sirius
  for_each = {
    for name, vm in var.vm_list :
    name => vm
    if vm.proxmox_node == "sirius"
  }

  name        = each.key
  node_name   = each.value.proxmox_node
  description = each.value.description

  cpu {
    cores = each.value.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  initialization {
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = each.value.gateway
      }
    }

    user_account {
      username = "lab"
      keys     = var.public_keys
    }
  }

  disk {
    datastore_id = each.value.datastore_id
    file_id      = "local:iso/ubuntu-24.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = each.value.disk_size
  }

  network_device { bridge = "vmbr0" }

  tags    = each.value.tags
  on_boot = false
}

# VMs that should use the "polaris" alias
resource "proxmox_virtual_environment_vm" "vm_ubuntu_polaris" {
  provider = proxmox.polaris
  for_each = {
    for name, vm in var.vm_list :
    name => vm
    if vm.proxmox_node == "polaris"
  }

  name        = each.key
  node_name   = each.value.proxmox_node
  description = each.value.description

  cpu {
    cores = each.value.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  initialization {
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = each.value.gateway
      }
    }

    user_account {
      username = "lab"
      keys     = var.public_keys
    }
  }

  disk {
    datastore_id = each.value.datastore_id
    file_id      = "local:iso/ubuntu-24.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = each.value.disk_size
  }

  network_device { bridge = "vmbr0" }

  tags    = each.value.tags
  on_boot = false
}
