resource "digitalocean_droplet" "this" {
  name       = var.name
  size       = var.size
  image      = data.digitalocean_images.this.images.0.id # top result from filter
  region     = var.region
  vpc_uuid   = var.vpc_uuid
  monitoring = var.monitoring
  ssh_keys   = var.ssh_enabled ? local.ssh_keys : null
  user_data  = var.cloudinit_enabled ? data.cloudinit_config.this.0.rendered : null

  tags = concat(
    local.tags,
    local.ssh_tags,
  )
}
