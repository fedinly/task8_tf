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
  route_table_id = yandex_vpc_route_table.rt_web.id
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_db_name
  zone           = var.db_zone
  network_id     = yandex_vpc_network.develop_db.id
  v4_cidr_blocks = var.db_cidr
  route_table_id = yandex_vpc_route_table.rt_db.id
}

resource "yandex_vpc_gateway" "nat_gateway_web" {
  name = local.name_gw1
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt_web" {
  name = "route-table-web"
  network_id = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway_web.id
  }
}

resource "yandex_vpc_gateway" "nat_gateway_db" {
  name = local.name_gw2
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt_db" {
  name = "route-table-db"
  network_id = yandex_vpc_network.develop_db.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway_db.id
  }
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
    nat       = false
  }

  metadata = var.vms_metadata
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
    nat       = false
  }

  metadata = var.vms_metadata
}