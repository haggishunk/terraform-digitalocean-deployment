resource "digitalocean_volume" "data" {
  count                   = var.volume_enabled ? 1 : 0
  region                  = var.region
  name                    = var.volume_name
  size                    = var.volume_size
  initial_filesystem_type = var.volume_fs
  description             = var.volume_description
}

resource "digitalocean_volume_attachment" "data" {
  count      = var.volume_enabled ? 1 : 0
  droplet_id = digitalocean_droplet.this.id
  volume_id  = digitalocean_volume.data.0.id
}
