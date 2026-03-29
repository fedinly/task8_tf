resource "yandex_vpc_network" "develop" {

  name = var.vpc_name
}
resource "yandex_vpc_network" "develop_db" {

  name = var.vpc_db_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_db_name
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop_db.id
  v4_cidr_blocks = var.db_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_name
}
resource "yandex_compute_instance" "platform" {
  name        = local.name_web

  platform_id = "standard-v1"
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vms_resources.web.hdd_size
      type = var.vms_resources.web.hdd_type
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
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}

resource "yandex_compute_instance" "platform01" {
  name        = local.name_db
  zone =  var.db_zone
  platform_id = "standard-v1"
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vms_resources.db.hdd_size
      type = var.vms_resources.db.hdd_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
