variable "app_name" {
  description = ""
  type        = string
}

variable "app_plan_id" {
  description = ""
  type        = string
}

variable "rg" {
  description = ""
  type        = string
}

variable "location" {
  description = ""
  type        = string
}

variable "app_scope" {
  description = ""
  type        = string
  default     = "common"
}

variable "app_prefix" {
  description = ""
  type        = string
  default     = "as"
}

variable "app_environment" {
  description = ""
  type        = map
  default     = {}

}

variable "dns_zone" {
  description = ""
  type        = string
  default     = ""
}

variable "dns_rg" {
  description = ""
  type        = string
  default     = ""
}

variable "dns_name" {
  description = ""
  type        = string
  default     = ""
}

variable "dns_subdomain" {
  description = ""
  type        = string
  default     = ""
}

variable "dns_ttl" {
  description = ""
  type        = number
  default     = 3600
}

variable "tag_length" {
  description = ""
  type        = number
  default     = 3
}

variable "ssl_cert_thumbprint" {
  description = ""
  type        = string
  default     = ""
}

variable "ssl_state" {
  description = ""
  type        = string
  default     = "SniEnabled"
}

variable "recreate_trigger" {
  description = ""
  type        = number
  default     = 1
}

variable "site_scm_type" {
  description = ""
  type        = string
  default     = "LocalGit"
}

variable "site_linux_fx_version" {
  description = ""
  type        = string
  default     = "PYTHON|3.8"
}

variable "site_always_on" {
  description = ""
  type        = bool
  default     = false
}
