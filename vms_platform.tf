variable "vm_image_name" {
  type    = string
  default ="ubuntu-2004-lts"
}

variable "vm_web_instance_name" {
  type    = string
  default = "netology-develop-platform-web"
}

variable "vm_db_instance_name" {
  type    = string
  default = "netology-develop-platform-db"
}

/*###ssh vars
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINr3q4XMUJOIlOWLSTiBku/QtmX2t4qtGtIaZW+wy52V fedinly@gmail.com"
  description = "ssh-keygen -t ed25519"
}*/

variable "vms_resources" {}

variable "vms_metadata" {}