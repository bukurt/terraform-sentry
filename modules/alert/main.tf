# Retrieve integrations
data "sentry_organization_integration" "slack" {
  organization = var.org

  provider_key = "slack"
  name         = var.slack_workspace_name
}
data "sentry_organization_integration" "opsgenie" {
  organization = var.org

  provider_key = "opsgenie"
  name         = var.opsgenie_integration_name
}

locals {
  action_slack = [{
      id = "sentry.integrations.slack.notify_action.SlackNotifyServiceAction"
      workspace = data.sentry_organization_integration.slack.id
      channel = try(var.actions.slack.channel_name, "")
      tags = "environment,level"
    }]
  action_opsgenie = [{
      id      = "sentry.integrations.opsgenie.notify_action.OpsgenieNotifyTeamAction"
      account = data.sentry_organization_integration.opsgenie.id
      team    = var.opsgenie_integration_team
    }]
  slack_enabled = try(var.actions.slack.enabled, false) ? local.action_slack : []
  opsgenie_enabled = try(var.actions.opsgenie.enabled, false) ? local.action_opsgenie : []
  all_actions = local.slack_enabled == [] && local.opsgenie_enabled == [] ? var.default_action : concat(local.slack_enabled, local.opsgenie_enabled)
}


resource "sentry_issue_alert" "issue_alert" {
  count        = var.alert_type == "issue_alert" ? 1 : 0
  organization = var.org
  project      = var.project_name
  name         = "[TF](${var.project_name})${var.opsgenie_alert_rule} ${var.alert_name}"

  environment  = var.alert_environment
  action_match = var.action_match
  filter_match = var.filter_match
  frequency    = var.alert_frequency

  conditions = var.conditions
  actions = local.all_actions

}


resource "sentry_metric_alert" "metric_alert" {
  count        = var.alert_type == "metric_alert" ? 1 : 0
  organization = var.org
  project      = var.project_name
  name         = "[TF](${var.project_name})${var.opsgenie_alert_rule} ${var.alert_name}"

  dataset           = "events"
  event_types       = ["error"]
  query             = var.query
  aggregate         = var.aggregate
  time_window       = var.time_window
  threshold_type    = var.threshold_type
  resolve_threshold = var.resolve_threshold

  dynamic "trigger" {
    for_each = try(var.triggers, toset([]))
    
    content {
      alert_threshold = trigger.value.alert_threshold
      label           = trigger.value.label
      threshold_type  = 0
      action {
        type              = trigger.value.action.type
        target_type       = "specific"
        target_identifier = trigger.value.action.target
        integration_id = trigger.value.action.type == "slack" ? data.sentry_organization_integration.slack.id : data.sentry_organization_integration.opsgenie.id
      
      }
    }
  }
}


