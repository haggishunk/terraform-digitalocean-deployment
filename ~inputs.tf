# project level
variable project_name {
  type = string
}

# module level
variable name {
  type = string
}

variable tags {
  type        = list(string)
  description = "List of tag strings"
}

variable size {
  type    = string
  default = "1gb"
}

variable image_id {
  type        = string
  description = "(Optional) This id will be added as an exact match on image filters."
  default     = null
}

variable image_name {
  type        = string
  description = "(Optional) This name will be added as a regex match on image filters."
  default     = null
}

variable image_slug {
  type        = string
  description = "(Optional) This slug will be added as a regex match on image filters."
  default     = null
}

variable image_source {
  type        = string
  description = "(Optional) This source (distribution) will be added as an exact match on image filters."
  default     = null
}

variable image_filters {
  type = map(object({
    key      = string
    values   = list(string)
    match_by = string
    all      = bool
  }))
  description = "(Optional) Map of objects representing filter `key`, `values`, `match_by` and `all` for image selection."
  default     = {}
}

variable image_latest {
  type        = bool
  description = "(Optional) Set to `true` to pick the latest of image that matches provided filters and arranged by sort.  Defaults to `true`."
  default     = true
}

variable image_sort {
  type        = map(string)
  description = "(Optional) Map of sort `key`, `direction` for droplet images.  Note that the default setting of `image_latest` to `true` overrides anything specified here."
  default     = {}
}

variable region {
  type        = string
  description = "Region to deploy resources to.  Also filters droplet images."
}

variable private_networking {
  type    = bool
  default = true
}

variable monitoring {
  type    = bool
  default = true
}

variable ssh_enabled {
  type    = bool
  default = false
}

variable ssh_keys_ids {
  type    = list(string)
  default = []
}

variable ssh_keys_names {
  type    = list(string)
  default = []
}

variable dns_enabled {
  type    = bool
  default = false
}

variable domain {
  type    = string
  default = null
}

variable reserved_ip_enabled {
  type    = bool
  default = false
}

variable volume_enabled {
  type    = bool
  default = false
}

variable volume_name {
  type    = string
  default = "data"
}

variable volume_mount {
  type    = string
  default = "/data"
}

variable volume_size {
  type    = number
  default = 10
}

variable volume_fs {
  type    = string
  default = "ext4"
}

variable volume_description {
  type    = string
  default = null
}

variable inbound_rules {
  type = map(object({
    port_range       = string
    protocol         = string
    source_addresses = list(string)
    source_tags      = list(string)
  }))
  default = {}
}

variable outbound_rules {
  type = map(object({
    port_range            = string
    protocol              = string
    destination_addresses = list(string)
    destination_tags      = list(string)
  }))
  default = {}
}

variable certs_enabled {
  type    = bool
  default = false
}

variable tls_cert {
  type    = string
  default = "REPLACE ME"
}

variable tls_key {
  type    = string
  default = "REPLACE ME"
}

variable ca_cert {
  type    = string
  default = "REPLACE ME"
}

variable ca_trust_enabled {
  type    = bool
  default = false
}

variable cert_path {
  type    = string
  default = "/etc/certificates"
}

variable cloudinit_enabled {
  type        = bool
  description = "(Optional) Enable cloudinit scripts supplied via `cloudinit_config_parts`.  Note that setting `volume_enabled` will execute a cloudinit script not enabled/disabled by this setting."
  default     = false
}

variable cloudinit_config_parts {
  type = map(object({
    content      = string
    content_type = string
  }))
  description = "(Optional) Map of content and content type to construct into cloudinit script."
  default     = {}
}
