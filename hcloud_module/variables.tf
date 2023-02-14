
variable "location" {
  default = "hel1-dc2"
  description = "this is finland datacenter"
}

variable "vm_name" {
  type = string
  description = "This will be the name of the vm"
  default = "cloud_vm"
}

variable "server_type" {
  type        = string
  description = "server type in hetzner"
  default = "cx11"

}

variable "os_type" {
  default = "ubuntu-22.04"
}

variable "storage_id" {
  type = string
  default = "None"
}

variable "project_id" {
  type = string
  default = "None"
}

variable "docker_image" {
  type = string
  default = "None"
}

variable "command" {
  type = string
  default = "None"
}

variable "primary_ip_name" {
  type        = string
  description = "ip_address name in hetzner"
  default = "primary_ip"

}

variable "ssh_name" {
  type = string
  description = "ssh_key name in hertzner"
  default = "Cloud public key"
}

