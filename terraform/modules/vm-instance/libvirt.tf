# Defining VM Volume
resource "libvirt_volume" "fedora-qcow2" {
  count  = var.amount
  name   = "${var.domain.name}-${count.index}.${var.volume.format}"
  pool   = "default"
  source = var.volume.source
  format = var.volume.format
}

# get user data info
data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  count     = var.amount
  name      = "${var.domain.name}-${count.index}"
  pool      = "default" # List storage pools using virsh pool-list
  user_data = data.template_file.user_data.rendered
}

# Define KVM domain to create
resource "libvirt_domain" "fedora" {
  count  = var.amount
  name   = "${var.domain.name}-${count.index}"
  memory = var.domain.memory
  vcpu   = var.domain.vcpu

  network_interface {
    network_name   = var.network_name
    wait_for_lease = "true"
  }

  disk {
    volume_id = libvirt_volume.fedora-qcow2[count.index].id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# Output Server IP
#output "ip" {
#  value = libvirt_domain.fedora.network_interface.0.addresses.0
#}

