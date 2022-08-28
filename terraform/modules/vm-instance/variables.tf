
variable "amount" {
  type = number
}
variable "volume" {
  type = object({
    source = string
    format = string
  })
}

variable "network_name" {
  type = string
}

variable "ip_offset" {
  type = number
}

variable "ip_prefix" {
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
