output "external_ip_address_vm1" {
  value = yandex_compute_instance.vm1.network_interface[0].nat_ip_address
}
output "external_ip_address_vm2" {
  value = yandex_compute_instance.vm2.network_interface[0].nat_ip_address
}