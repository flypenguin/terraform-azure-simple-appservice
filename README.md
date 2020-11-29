# simple-appservice module

This module creates a simple CI/CD App Service for Azure. The idea is that you specify _one_ resource (using the module) and get ...

* an App Service, which has `git push` deployments enabled
* mapped to a FQDN in a DNS domain you own and manage in Azure (optional)
* with SSL enabled and activated by default (optional)

## Configuration defaults

* Linux Runtime, `LocalGit` configuration

## Limitations

* The DNS domain you use must be managed in Azure
* You have to buy the certificate :(
* No App Service Slots

## Full example

```hcl
resource "azurerm_app_service_plan" "plan" {
  name                = "my-appserviceplan"
  location            = "West Europe"
  resource_group_name = "my-resourcegroup"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

module "myappservice" {
  # this is local development
  source = "../modules/az/simple-appservice"

  app_name    = "my-appservice"
  rg          = "my-resourcegroup"
  location    = "West Europe"
  app_plan_id = azurerm_app_service_plan.plan.id

  # optional
  dns_zone    = "my-azure-managed-domain.de"
  dns_rg      = "my-dns-resourcegroup"
  dns_ttl     = 300

  # optional
  ssl_cert_pfx_blob = filebase64("${path.root}/my-azure-managed-domain-cert.pfx")
  ssl_cert_pfx_pass = "some-really-badass-password"

  app_environment = merge(
    # MAKE ABSOLUTELY SURE THERE IS AT LEAST ONE ENTRY IN EACH OF THE YAML FILES!!
    yamldecode(file("${path.root}/settings.public.yaml")),
    yamldecode(file("${path.root}/settings.secret.yaml")),
    { "DATABASE_URL" : "postgres://myuser:mypass@mydb.here" },
  )
}
```

That's it.

### Notes

* `dns_rg` is optional and defaults to `rg` if not given
* if you specify `ssl_cert_pfx_blob` then `https_only` is automatically enabled on the service
* the app service's name is always something like `<prefix>-<scope>-<name>-<tag>`, with ...
  * `<prefix>` defaults to `as` (for `appservice`, right? ;)
  * `<scope>` defaults to `common`
  * `<name>` is the name you specified
  * `<tag>` will be a random string with by default 3 letters
  * **WHY** do I do this? cause the name must be unique world-wide, this is the way I ensure it
* the DNS entry will only be the `<name>` part, of course :) , but that can be overridden.
