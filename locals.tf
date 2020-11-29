locals {
  name_tag     = "${var.app_name}-${random_string.rnd.result}"
  dep_name_tag = join("-", compact(list(var.app_scope, var.app_name)))
  full_name    = join("-", compact(list(var.app_prefix, var.app_scope, local.name_tag)))
  dns_name     = var.dns_name != "" ? var.dns_name : var.app_name
  dns_domain   = join(".", compact(list(var.dns_subdomain, var.dns_zone)))
  dns_entry    = join(".", compact(list(local.dns_name, var.dns_subdomain)))
  dns_fqdn     = "${local.dns_entry}.${var.dns_zone}"
}
