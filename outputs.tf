output "scm" {
  value = azurerm_app_service.service.source_control
}

output "site_credentials" {
  value = azurerm_app_service.service.site_credential
}

output "full_name" {
  value = local.full_name
}

output "name_tag" {
  value = random_string.rnd.result
}
