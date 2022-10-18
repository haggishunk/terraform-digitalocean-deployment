resource "digitalocean_firewall" "this" {
  name        = local.name
  droplet_ids = [digitalocean_droplet.this.id]
  tags        = local.firewall_tags

  dynamic "inbound_rule" {
    for_each = var.inbound_rules
    content {
      port_range       = inbound_rule.value.port_range
      protocol         = inbound_rule.value.protocol
      source_addresses = inbound_rule.value.source_addresses
      source_tags      = inbound_rule.value.source_tags
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_rules
    content {
      port_range            = outbound_rule.value.port_range
      protocol              = outbound_rule.value.protocol
      destination_addresses = outbound_rule.value.destination_addresses
      destination_tags      = outbound_rule.value.destination_tags
    }
  }
}
