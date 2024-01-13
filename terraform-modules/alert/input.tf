variable "org" {
  description = "Sentry organization name"
  type        = string
}

variable "alert_type" {
    type        = string
}

variable "project_name" {
  description = " The human readable name for the project."
  type        = string
  validation {
    condition     = can(regex("^[a-z]+[a-z0-9]+-?[a-z0-9]+", var.project_name))
    error_message = "The project_name value must fit into regex /[a-z]+[a-z0-9]+-?[a-z0-9]+/. Examples: my-proj, my-prod01, my01-proj2, mandoproj."
  }
}

variable "opsgenie_alert_rule" {
  description = "It can be either 'Valinor Trade', 'Valinor Market Data', 'Khazad Onboarding', 'Khazad Money Transfer'"
  type        = string
  default     = ""
}

variable "alert_environment" {
  description = "How often this alert will be run"
  type        = string
  default     = "production"
}

variable "action_match" {
 type = string 
 default = null
}

variable "filter_match" {
  type = string
  default = null
}

variable "opsgenie_integration_name" {
  description = "Opsgenie integration name."
  type        = string
}

variable "slack_workspace_name" {
  description = "Slack workspace name."
  type        = string
  default     = "Midas"
}

variable "alert_name" {
  description = "Name of the alert"
  type = string
}

variable "conditions" {}

variable "filters" {
  default = null
}

variable "actions" {
  default = null
}

variable "triggers" {
  type = list(object({
    label           = string
    alert_threshold = number
    action = object({
      type              = string
      target = string
    })
  }))
  default = null
}


variable "alert_frequency" {
  type = number
  default =30
}

variable "opsgenie_integration_team" {
  description = "Opsgenie team name in integration."
  type        = string
  default     = "238893-my-first-key"
}

variable "default_action" {
  default = [{
    id = "sentry.mail.actions.NotifyEmailAction",
    targetType = "IssueOwners",
    fallthroughType = "ActiveMembers"
  }]
}

variable "threshold_type" {
  type = number
  default = 0
}

variable "query" {
  type = string
  default = ""
}

variable "aggregate" {
  type = string
  default = "count()"
}

variable "time_window" {
  type = number
  default = null
}

variable "resolve_threshold" {
  type = number
  default = null
}
