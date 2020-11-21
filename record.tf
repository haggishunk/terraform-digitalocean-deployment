resource "digitalocean_record" "this" {
  count  = var.dns_enabled ? 1 : 0
  domain = var.domain
  type   = "A"
  name   = var.name
  value  = var.floating_ip_enabled ? digitalocean_floating_ip.this.0.ip_address : digitalocean_droplet.this.ipv4_address
}
