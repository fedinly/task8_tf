vms_resources = {
  web={
    cores=2
    memory=1
    core_fraction=5
    hdd_size=5
    hdd_type="network-hdd"
  },
  db= {
    cores=2
    memory=2
    core_fraction=20
    hdd_size=5
    hdd_type="network-hdd"
  }
}
vms_metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINr3q4XMUJOIlOWLSTiBku/QtmX2t4qtGtIaZW+wy52V fedinly@gmail.com"
}