module "vm-instances1" {
  source = "../vm-instance"
  amount = 2
  volume = {
    source = "/home/leon/dev/k8s-learing/terraform/base-image/Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
    format = "qcow2"
    name   = "fedora1.qcow2"
  }
  domain = {
    memory = "2024"
    name   = "fedora"
    vcpu   = 2
  }
  cloudinit = "fedora"
}


#module "vm-instances2" {
#  source = "../vm-instance"
#  volume = {
#    source = "/home/leon/dev/k8s-learing/terraform/base-image/Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
#    format = "qcow2"
#    name   = "fedora2.qcow2"
#  }
#  domain = {
#    memory = "2024"
#    name   = "fedora2"
#    vcpu   = 2
#  }
#  cloudinit = "fedora2"
#}
