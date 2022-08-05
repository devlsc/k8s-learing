# Defining VM Volume
resource "libvirt_volume" "fedora-qcow2" {
  name   = "fedora.qcow2"
  pool   = "default"
  source = "./Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
  format = "qcow2"
}

# get user data info
data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  pool      = "default" # List storage pools using virsh pool-list
  user_data = data.template_file.user_data.rendered
}

# Define KVM domain to create
resource "libvirt_domain" "fedora" {
  name   = var.domain.name
  memory = var.domain.memory
  vcpu   = var.domain.vcpu

  network_interface {
    network_name   = "default"
    wait_for_lease = "true"
  }

  disk {
    volume_id = libvirt_volume.fedora-qcow2.id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id

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
output "ip" {
  value = libvirt_domain.fedora.network_interface.0.addresses.0
}

