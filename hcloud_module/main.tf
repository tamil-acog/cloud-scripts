
resource "hcloud_ssh_key" "default" {
  name       = var.ssh_name
  public_key = file("~/.ssh/id_rsa.pub")
}


data "template_file" "user_data" {
  template = file("./user_data.yml")
}



resource "hcloud_primary_ip" "primary_ip" {
  name          = var.primary_ip_name
  datacenter    = var.location
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
  labels = {
    "ip" : "server"
  }
}


resource "hcloud_server" "cloudvm" {
  name        = var.vm_name
  image       = var.os_type
  datacenter  = var.location
  server_type = var.server_type
  user_data   = data.template_file.user_data.rendered
  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.primary_ip.id
    ipv6_enabled = false
  }
  labels = {
    test : "initial-vm-provisioning"
  }
  ssh_keys = ["${hcloud_ssh_key.default.id}"]
  # provisioning my private ssh key to remote machine for rsync to storage box, or any authentication.


provisioner "file" {
    source      = "~/.ssh/id_rsa"
    destination = "/root/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = "root"
      host        = hcloud_server.cloudvm.ipv4_address
      private_key = file("~/.ssh/id_rsa")

    }
  }
provisioner "file" {
    source      = "~/.ssh/storagebox/id_rsa"
    destination = "/root/id_rsa"

    connection {
      type        = "ssh"
      user        = "root"
      host        = hcloud_server.cloudvm.ipv4_address
      private_key = file("~/.ssh/id_rsa")

    }
  }

provisioner "file" {
    source      = "~/.ssh/known_hosts"
    destination = "/root/.ssh/known_hosts"

    connection {
      type        = "ssh"
      user        = "root"
      host        = hcloud_server.cloudvm.ipv4_address
      private_key = file("~/.ssh/id_rsa")

    }
  }

provisioner "file" {
    source      = "~/.ssh/config"
    destination = "/root/.ssh/config"

    connection {
      type        = "ssh"
      user        = "root"
      host        = hcloud_server.cloudvm.ipv4_address
      private_key = file("~/.ssh/id_rsa")

    }
  }

provisioner "file" {
    source      = "./code.sh"
    destination = "/tmp/code.sh"
    connection {
      type        = "ssh"
      user        = "root"
      host        = hcloud_server.cloudvm.ipv4_address
      private_key = file("~/.ssh/id_rsa")

    }
  }

provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/code.sh",
      "/tmp/code.sh ${var.storage_id} ${var.project_id} ${var.docker_image} ${var.command}"
    ]
    when = create

    connection {
      type        = "ssh"
      user        = "root"
      host        = hcloud_server.cloudvm.ipv4_address
      private_key = file("~/.ssh/id_rsa")

    }
  }

}

resource "null_resource" "destroy" {
  depends_on = [hcloud_server.cloudvm]
  
  provisioner "local-exec" {
    command = <<EOF
      ssh-keyscan ${hcloud_server.cloudvm.ipv4_address} >> ~/.ssh/known_hosts

      if [ "$(ssh root@${hcloud_server.cloudvm.ipv4_address} 'cat /root/metadata/done.txt')" = "DONE" ]; then
        terraform destroy -auto-approve -lock=false
      fi
    EOF
    when = create
  }
}















