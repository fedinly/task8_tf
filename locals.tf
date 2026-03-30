locals {
  name_web = "${var.vm_web_instance_name}-${var.default_zone}"
  name_db = "${var.vm_db_instance_name}-${var.db_zone}"
  name_gw1 = "${var.vm_gw-web_instance_name}-${var.default_zone}"
  name_gw2 = "${var.vm_gw-db_instance_name}-${var.db_zone}"
}