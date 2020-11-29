data "azurerm_dns_zone" "zone" {
  count = var.dns_zone != "" ? 1 : 0

  name                = var.dns_zone
  resource_group_name = var.dns_rg != "" ? var.dns_rg : var.rg
}

resource "azurerm_app_service_custom_hostname_binding" "binding" {
  count = var.dns_zone != "" ? 1 : 0

  resource_group_name = var.rg
  app_service_name    = azurerm_app_service.service.name
  hostname            = local.dns_fqdn
  ssl_state           = var.ssl_cert_pfx_blob != "" ? var.ssl_state : null
  thumbprint          = var.ssl_cert_pfx_blob != "" ? azurerm_app_service_certificate.cert[0].thumbprint : null
}

resource "azurerm_dns_cname_record" "cname" {
  count = var.dns_zone != "" ? 1 : 0

  name                = local.dns_entry
  record              = "${local.full_name}.azurewebsites.net" # https://is.gd/c3Qe9X
  zone_name           = var.dns_zone
  resource_group_name = var.dns_rg != "" ? var.dns_rg : var.rg
  ttl                 = var.dns_ttl
}
