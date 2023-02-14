output "server_ip_ubuntu" {
  value = hcloud_server.cloudvm.ipv4_address
}