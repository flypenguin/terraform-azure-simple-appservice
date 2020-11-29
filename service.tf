resource "random_string" "rnd" {
  keepers = {
    recreate_trigger = var.recreate_trigger
  }
  lower   = true
  special = false
  number  = false
  upper   = false
  length  = var.tag_length
}

resource "azurerm_app_service" "service" {
  name                = local.full_name
  location            = var.location
  resource_group_name = var.rg
  app_service_plan_id = var.app_plan_id
  app_settings        = var.app_environment
  https_only          = var.ssl_cert_pfx_blob != "" ? true : null

  site_config {
    scm_type         = var.site_scm_type != "" ? var.site_scm_type : null
    linux_fx_version = var.site_linux_fx_version != "" ? var.site_linux_fx_version : null
    always_on        = var.site_always_on ? true : null
  }
}
