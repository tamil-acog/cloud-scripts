
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

variable "user_input" {
  type = object({
  storage_id = string
  project_id = string
  docker_image = string
  command = string
  })
  default = ({
    storage_id = "None"
    project_id = "None"
    docker_image = "None"
    command = "None"
    })
  description = "This will be set by the user"
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

