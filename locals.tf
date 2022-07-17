locals {
  # simple naming
  name = coalesce(var.name, var.project_name)

  # everything this module creates gets these
  module_tags = [
    "project:${var.project_name}",
    "name:${local.name}",
    "managed_by:terraform",
  ]

  tags = concat(
    local.module_tags,
    var.tags,
  )

  # remember max number of 5 tags ... keep them simple and sensibly scoped
  # use the `access:` tag key
  firewall_tags = ["access:${var.name}"]

  # ssh firewall controlled by `ssh:true` tag
  ssh_tags = var.ssh_enabled ? ["ssh:true"] : []

  # droplet image selections
  image_filter_id = var.image_id != null ? {
    "id" = {
      "key"      = "id"
      "values"   = [var.image_id]
      "match_by" = "exact"
      "all"      = true
    }
  } : {}

  image_filter_name = var.image_name != null ? {
    "id" = {
      "key"      = "name"
      "values"   = [var.image_name]
      "match_by" = "re"
      "all"      = true
    }
  } : {}

  image_filter_slug = var.image_slug != null ? {
    "id" = {
      "key"      = "slug"
      "values"   = [var.image_slug]
      "match_by" = "re"
      "all"      = true
    }
  } : {}

  image_filter_source = var.image_source != null ? {
    "id" = {
      "key"      = "distribution"
      "values"   = [var.image_source]
      "match_by" = "exact"
      "all"      = true
    }
  } : {}

  image_filters = merge(
    local.image_filter_id,
    local.image_filter_name,
    local.image_filter_slug,
    local.image_filter_source,
    var.image_filters,
  )

  # ssh access selection
  ssh_keys_from_filter = [for k in data.digitalocean_ssh_keys.this.ssh_keys : k.id]
  ssh_keys             = var.ssh_enabled ? concat(var.ssh_keys_ids, local.ssh_keys_from_filter) : null

  # general module defs
  dir_files     = "${path.module}/files"
  dir_templates = "${path.module}/templates"

  script_mount_volume = templatefile(
    "${local.dir_templates}/mount-volume-by-name.sh.tpl",
    {
      DATA_VOLUME_NAME  = var.volume_name
      DATA_VOLUME_MOUNT = var.volume_mount
    },
  )

  script_cert_setup = templatefile(
    "${local.dir_templates}/cert-install.sh.tpl",
    {
      TLS_CRT   = var.tls_cert
      TLS_KEY   = var.tls_key
      CERT_PATH = var.cert_path
    },
  )

  script_ca_trust = templatefile(
    "${local.dir_templates}/ubuntu-ca-trust.sh.tpl",
    {
      CA_CRT = var.ca_cert
    },
  )

  cloudinit_config_parts = merge(
    var.volume_enabled ? {
      "volume" = {
        content_type = "text/x-shellscript"
        content      = local.script_mount_volume
      }
    } : {},
    var.certs_enabled ? {
      "certs" = {
        content_type = "text/x-shellscript"
        content      = local.script_cert_setup
      }
    } : {},
    var.ca_trust_enabled ? {
      "ca" = {
        content_type = "text/x-shellscript"
        content      = local.script_ca_trust
      }
    } : {},
    var.cloudinit_config_parts,
  )
}
