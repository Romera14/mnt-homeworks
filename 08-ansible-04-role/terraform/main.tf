resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

output "yandex_compute_instance_platform_name" {
  value       = yandex_compute_instance.platform[*].name
}

output "external_ip_address_platform" {
  value = yandex_compute_instance.platform[*].network_interface[0].nat_ip_address
}

