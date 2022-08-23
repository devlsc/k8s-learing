terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "kube_network" {
  name      = "kubernetes-nw"
  mode      = "nat"
  domain    = "kubernetes-nw"
  addresses = ["10.240.0.0/24"]
}

module "load-balancer" {
  source = "../../modules/vm-instance"
  amount = 1
  volume = {
    source = "/home/leon/dev/k8s-learing/terraform/base-image/Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
    format = "qcow2"
  }
  network_name = "kubernetes-nw"
  domain = {
    memory = "256"
    name   = "lb"
    vcpu   = 1
  }
  cloudinit = "fedora"
}

module "kubernetes-controller" {
  source = "../../modules/vm-instance"
  amount = 3
  volume = {
    source = "/home/leon/dev/k8s-learing/terraform/base-image/Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
    format = "qcow2"
  }
  network_name = "kubernetes-nw"
  domain = {
    memory = "512"
    name   = "controller"
    vcpu   = 1
  }
  cloudinit = "fedora"
}

module "worker" {
  source = "../../modules/vm-instance"
  amount = 3
  volume = {
    source = "/home/leon/dev/k8s-learing/terraform/base-image/Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
    format = "qcow2"
  }
  network_name = "kubernetes-nw"
  domain = {
    memory = "1024"
    name   = "worker"
    vcpu   = 1
  }
  cloudinit = "fedora"
}

module "client" {
  source = "../../modules/vm-instance"
  amount = 1
  volume = {
    source = "/home/leon/dev/k8s-learing/terraform/base-image/Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
    format = "qcow2"
  }
  network_name = "kubernetes-nw"
  domain = {
    memory = "256"
    name   = "client"
    vcpu   = 1
  }
  cloudinit = "fedora"
}