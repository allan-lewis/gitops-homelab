terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.78.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm_haos" {
  for_each = var.vm_list

  name      = each.key
  node_name = each.value.proxmox_node
  description = each.value.description

  cpu {
    cores = each.value.cpu_cores
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  network_device {
    bridge = "vmbr0"
  }

  tags = each.value.tags
  on_boot     = true
}
