output "organization" {
  value = "${data.sentry_organization.main.name} (${data.sentry_organization.main.slug})"
}

output "project" {
  value = sentry_project.sentry_project.slug
}

output "keys" {
    # for_each = sentry_key.keys
    # value = sentry_key.keys[each.value].dsn_public
    value = [
        for key in sentry_key.keys : var.print_keys ? "${sentry_project.sentry_project.slug} (${key.name}): ${key.dsn_public}" : "${sentry_project.sentry_project.slug} (${key.name}): ************"
    ]
}