
variable "amount" {
  type = number
}
variable "volume" {
  type = object({
    name   = string
    source = string
    format = string
  })
}

variable "cloudinit" {
  type = string
}



variable "domain" {
  type = object({
    memory = string
    name   = string
    vcpu   = number
  })
  description = "describes the vm base configuration"
}
