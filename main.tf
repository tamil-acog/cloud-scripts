module "hcloud_machines" {
    source = "./hcloud_module"
    vm_name = var.machine_name
    primary_ip_name = var.ip_name
    ssh_name = var.ssh_key_name
    storage_id = var.user_input.storage_id
    project_id = var.user_input.project_id
    docker_image = var.user_input.docker_image
    command = var.user_input.command 
    server_type = var.user_input.machine_type
}