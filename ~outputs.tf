output droplet_dnsname {
  value = var.dns_enabled ? digitalocean_record.this.0.fqdn : null
}

output floating_ip {
  value = var.floating_ip_enabled ? digitalocean_floating_ip.this.0.ip_address : null
}

output droplet_ip {
  value = digitalocean_droplet.this.ipv4_address
}

output cloudinit_configs {
  value       = var.cloudinit_enabled ? keys(local.cloudinit_config_parts) : null
  description = "A list of enabled cloudinit configurations"
}

output deployment_tags {
  value = var.tags
}

output tags {
  value = local.tags
}

output cloudinit_rendered {
  value     = var.cloudinit_enabled ? data.cloudinit_config.this.rendered : null
  sensitive = true # inspect state to debug rendered cloudinit parts
}

output droplet_image {
  value = data.digitalocean_images.this.images.0
}
