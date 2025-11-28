resource "google_compute_instance" "vm" {
  name         = "my-app-vm1"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    echo "Hello from VM" > /var/www/html/index.html
    apt-get update -y
    apt-get install -y apache2
    systemctl start apache2
  EOF
}

# Unmanaged instance group (simple)
resource "google_compute_instance_group" "instance_group" {
  name        = "my-instance-group"
  zone        = var.zone
  instances   = [google_compute_instance.vm.self_link]

  named_port {
    name = "http"
    port = 80
  }
}