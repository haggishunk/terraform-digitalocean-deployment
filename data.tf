data "digitalocean_domain" "this" {
  count = var.dns_enabled ? 1 : 0
  name  = var.domain
}

data "digitalocean_ssh_keys" "this" {
  filter {
    key    = "name"
    values = var.ssh_keys_names
  }
}

data "template_cloudinit_config" "this" {
  # digital ocean does not like gzipped or encoded data
  gzip          = false
  base64_encode = false

  dynamic "part" {
    for_each = local.cloudinit_config_parts
    content {
      content_type = part.value.content_type # "text/x-shellscript"
      content      = part.value.content
    }
  }
}

data "digitalocean_images" "this" {
  # common-sense region selection
  filter {
    key    = "regions"
    values = [var.region]
  }

  # optional latest selection
  dynamic "sort" {
    for_each = var.image_latest ? { "created" = "desc" } : var.image_sort
    content {
      key       = sort.key
      direction = sort.value
    }
  }

  dynamic "filter" {
    for_each = local.image_filters
    content {
      key    = filter.value.key
      values = filter.value.values
    }
  }
}
