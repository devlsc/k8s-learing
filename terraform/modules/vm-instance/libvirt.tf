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
  vars = {
    domain = "abcd"
  }
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  count     = var.amount
  name      = "${var.domain.name}-${count.index}"
  pool      = "default" # List storage pools using virsh pool-list
  user_data = data.template_file.user_data.rendered
}

# Define KVM domain to create
resource "libvirt_domain" "vm-instance" {
  count      = var.amount
  name       = "${var.domain.name}-${count.index}"
  memory     = var.domain.memory
  vcpu       = var.domain.vcpu
  qemu_agent = true


  network_interface {
    network_name = var.network_name
    hostname     = "${var.domain.name}_${count.index}.${var.network_name}"
    # 
    # LIBVIRT-0001:
    # Seems like we can't simply get a random IP address in combination with the "hostname" attribute.
    # If no IP address is provided the hostname will not be added to the dhcp entry list
    # in the virtual network, and therefore local dns resolving does not work.
    # This seems a little bit error prone, as soon as it's not /24 net this will fail,
    # in case I try to assign higher addresses.
    #
    # Could be a regression: https://github.com/dmacvicar/terraform-provider-libvirt/issues/708
    addresses      = ["${var.ip_prefix}.${var.ip_offset + count.index}"]
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
