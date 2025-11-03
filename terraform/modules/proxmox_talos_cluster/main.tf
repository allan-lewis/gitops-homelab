terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.86.0"
    }
    talos = {
      source = "siderolabs/talos"
      version = "0.9.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm_talos" {
  for_each = merge(var.controlplane_list, var.worker_list)

  name        = each.key
  node_name   = each.value.proxmox_node
  description = each.value.description

  tags    = each.value.tags
  on_boot = false

  cpu {
    cores = each.value.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  agent {
    enabled = false
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = each.value.datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = each.value.disk_size
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = each.value.datastore_id
    ip_config {
      ipv4 {
        address = join("", [each.value.ipv4_address, "/24"])
        gateway = each.value.gateway
      }
    }
  }
}

locals {
  talos = {
    version = "v1.9.1"
  }
}

resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  node_name               = var.node_name

  file_name               = "talos-${local.talos.version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/613e1592b2da41ae5e265e8789429f22e121aab91cb4deb6bc3c0b6262961245/${local.talos.version}/nocloud-amd64.raw.gz"
  decompression_algorithm = "gz"
  overwrite               = false
}

resource "null_resource" "pause_for_talos_ready" {
  provisioner "local-exec" {
    command = "echo 'Waiting 120 seconds for Talos nodes to boot and be ready...' && sleep 120"
  }

  depends_on = [proxmox_virtual_environment_vm.vm_talos]
}

resource "talos_machine_secrets" "machine_secrets" {}

data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoints            = [var.controlplane_list[keys(var.controlplane_list)[0]].ipv4_address]
}

data "talos_machine_configuration" "machineconfig_cp" {
  for_each = var.controlplane_list

  cluster_name        = var.cluster_name
  cluster_endpoint    = join("", ["https://", var.controlplane_list[keys(var.controlplane_list)[0]].ipv4_address, ":6443"])
  machine_type        = "controlplane"
  kubernetes_version  = "1.31.4"
  machine_secrets     = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "cp_config_apply" {
  for_each = var.controlplane_list

  depends_on                  = [null_resource.pause_for_talos_ready]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_cp[each.key].machine_configuration
  node                        = each.value.ipv4_address
}

data "talos_machine_configuration" "machineconfig_worker" {
  for_each = var.worker_list

  cluster_name        = var.cluster_name
  cluster_endpoint    = join("", ["https://", var.controlplane_list[keys(var.controlplane_list)[0]].ipv4_address, ":6443"])
  machine_type        = "worker"
  kubernetes_version  = "1.31.4"
  machine_secrets     = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "worker_config_apply" {
  for_each = var.worker_list

  depends_on                  = [null_resource.pause_for_talos_ready]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_worker[each.key].machine_configuration
  node                        = each.value.ipv4_address
}

resource "talos_machine_bootstrap" "bootstrap" {
  depends_on           = [talos_machine_configuration_apply.cp_config_apply, talos_machine_configuration_apply.worker_config_apply]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = var.controlplane_list[keys(var.controlplane_list)[0]].ipv4_address
}

resource "talos_cluster_kubeconfig" "kubeconfig" {
  depends_on           = [talos_machine_bootstrap.bootstrap]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = var.controlplane_list[keys(var.controlplane_list)[0]].ipv4_address
}

output "talosconfig" {
  value     = data.talos_client_configuration.talosconfig.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = resource.talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}

data "talos_cluster_health" "health" {
  depends_on           = [talos_machine_configuration_apply.cp_config_apply, talos_machine_configuration_apply.worker_config_apply]
  client_configuration = data.talos_client_configuration.talosconfig.client_configuration
  control_plane_nodes  = [for vm in var.controlplane_list : vm.ipv4_address]
  worker_nodes         = [for vm in var.worker_list : vm.ipv4_address]
  endpoints            = data.talos_client_configuration.talosconfig.endpoints
}

# Rely on environment variables to populate the Proxmox provider!
# https://registry.terraform.io/providers/bpg/proxmox/latest/docs#environment-variables-summary
# provider "proxmox" {
  # Use PROXMOX_VM_PUBLIC_KEY environment variable
  # endpoint = ""

  # Use PROXMOX_VE_USERNAME environment variable
  # username = "root@pam"

  # Use PROXMOX_VE_PASSWORD environment variable
  # password = ""

  # Use PROXMOX_VE_API_TOKEN environment variable
  # api_token = ""
# }
