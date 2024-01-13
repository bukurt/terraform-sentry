output "organization" {
  value = "${data.sentry_organization.main.name} (${data.sentry_organization.main.slug})"
}

output "project" {
  value = sentry_project.sentry_project.slug
}

output "keys" {
  value = [
    for key in sentry_key.keys : var.print_keys ? "${sentry_project.sentry_project.slug} (${key.name}): ${key.dsn_public}" : "${sentry_project.sentry_project.slug} (${key.name}): ************"
  ]
}
