resource "digitalocean_reserved_ip" "this" {
  count  = var.reserved_ip_enabled ? 1 : 0
  region = var.region
}

resource "digitalocean_reserved_ip_assignment" "this" {
  count      = var.reserved_ip_enabled ? 1 : 0
  ip_address = digitalocean_reserved_ip.this.0.ip_address
  droplet_id = digitalocean_droplet.this.id
}
