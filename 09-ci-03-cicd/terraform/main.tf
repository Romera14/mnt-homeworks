resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "centos" {
  family = var.linux_famaly
}

resource "yandex_compute_instance" "vm1" {
  name        = local.vm1_name
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vm1_resources.cores
    memory        = var.vm1_resources.memory
    core_fraction = var.vm1_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./cloud-init.yml")}"
  }

}

resource "yandex_compute_instance" "vm2" {
  name        = local.vm2_name
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vm1_resources.cores
    memory        = var.vm1_resources.memory
    core_fraction = var.vm1_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./cloud-init.yml")}"
  }

}
