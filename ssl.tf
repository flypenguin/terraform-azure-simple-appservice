resource "azurerm_app_service_certificate" "cert" {
  count = var.ssl_cert_pfx_blob != "" ? 1 : 0

  name                = local.full_name
  resource_group_name = var.rg
  location            = var.location
  pfx_blob            = var.ssl_cert_pfx_blob
  password            = var.ssl_cert_pfx_pass != "" ? var.ssl_cert_pfx_pass : null
}
