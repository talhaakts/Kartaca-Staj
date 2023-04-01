provider "google" {
  credentials = file("service-account.json")
  project = var.gcp_project
  region = var.region
  zone = var.zone
}

resource "google_project_service" "services" {
  for_each = toset(var.gcp_service_list)
  project                    = var.gcp_project
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name   = "nat"
  router = google_compute_router.router.name
  region = var.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.subnet_1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

}

resource "google_compute_network" "vpc_network" {
  name = "kartaca-staj"
  auto_create_subnetworks = false
  project = var.gcp_project
}
resource "google_compute_subnetwork" "subnet_1" {
  name          = "kartaca-subnet1"
  ip_cidr_range = "172.16.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "k8s-pods"
    ip_cidr_range = "172.22.0.0/16"
  }
  secondary_ip_range {
    range_name    = "k8s-services"
    ip_cidr_range = "172.16.2.0/24"
  }
}
resource "google_compute_subnetwork" "subnet_2" {
  name          = "kartaca-subnet2"
  ip_cidr_range = "172.16.3.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  project = var.gcp_project
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  project = var.gcp_project
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }
  allow {
  protocol = "udp"
    ports    = ["1-65535"]
  }
   allow {
  protocol = "icmp"
  }
  source_ranges = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24" ]
}
