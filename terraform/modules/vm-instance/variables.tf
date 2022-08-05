variable "domain" {
  type = object({
    memory = string
    name   = string
    vcpu   = number
  })
}
