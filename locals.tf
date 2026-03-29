locals {
  name_web = "${var.vm_web_instance_name}-${var.default_zone}"
  name_db = "${var.vm_db_instance_name}-${var.db_zone}"
}