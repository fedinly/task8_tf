output "instance_name" {
  value = [
    { web = [yandex_compute_instance.platform.name]},
    { db = [yandex_compute_instance.platform01.name]}
  ]
  description = "instance_name"
}
output "fqdn" {
  value = [
    { web = [yandex_compute_instance.platform.fqdn]},
    { db = [yandex_compute_instance.platform01.fqdn]}
  ]
  description = "fqdn"
}
output "external_ip" {
  value = [
    { web = [yandex_compute_instance.platform.network_interface[0].nat_ip_address]},
    { db = [yandex_compute_instance.platform01.network_interface[0].nat_ip_address]}
  ]
  description = "external_ip"
}