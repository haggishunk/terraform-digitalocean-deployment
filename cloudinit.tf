data "cloudinit_config" "this" {
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
