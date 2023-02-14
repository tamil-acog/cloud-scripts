variable "machine_name" {
  type = string
  default = "randomvm"
  description = "This will be the machine name"
}

variable "ip_name" {
  type = string
  default = "randomip"
}

variable "ssh_key_name" {
  type = string
  default = "randomssh"
}

variable "user_input" {
  type = object({
  storage_id = string
  project_id = string
  docker_image = string
  command = string
  machine_type = string
  })
  default = ({
    storage_id = "None"
    project_id = "None"
    docker_image = "None"
    command = "None"
    machine_type = "cx11"
    })
  description = "This will be set by the user"
}