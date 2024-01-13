data "sentry_organization" "main" {
  slug = var.org
}

resource "sentry_project" "sentry_project" {
  organization = var.org
  teams        = var.teams
  name         = var.project_name
  slug         = var.project_slug != null ? var.project_slug : null
  platform     = var.platform != null ? var.platform : null
  resolve_age  = var.project_resolve_age != null ? var.project_resolve_age : null
  default_key  = false
  default_rules = var.default_rules
}

resource "sentry_key" "keys" {
  for_each = var.key_rate_limits
  depends_on = [
    sentry_project.sentry_project
  ]
  organization      = var.org
  project           = sentry_project.sentry_project.slug
  name              = each.key
  rate_limit_count  = can(var.key_rate_limits[each.key].count) ? var.key_rate_limits[each.key].count : var.rate_limit_count_default
  rate_limit_window = can(var.key_rate_limits[each.key].window) ? var.key_rate_limits[each.key].window : var.rate_limit_window_default
}