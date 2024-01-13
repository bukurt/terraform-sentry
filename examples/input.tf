variable "org" {
  description = "Organization slug"
  type        = string
}

variable "sentry_token" {
  description = "Sentry token"
  type        = string
  sensitive   = true
}

variable "sentry_base_url" {
  description = "Sentry API address"
  type        = string
  default     = "https://sentry.io/api/"
}

variable "print_keys" {
  description = "Print keys as clear text or masked"
  type        = bool
  default     = false
}