variable "org" {
  description = "Sentry organization name"
  type        = string
}

# sentry_project resource variables
variable "teams" {
  description = "The slug of the team the project should be created for. All available teams are listed in https://midas-menkul.sentry.io/settings/teams/"
  type        = list(any)
}

variable "project_name" {
  description = " The human readable name for the project. Naming rule is resticted to have same name for both project name and prohect slug"
  type        = string
  validation {
    condition     = can(regex("^[a-z]+[a-z0-9]+-?[a-z0-9]+", var.project_name))
    error_message = "The project_name value must fit into regex /[a-z]+[a-z0-9]+-?[a-z0-9]+/. Examples: my-proj, my-prod01, my01-proj2, mandoproj."
  }
}

variable "project_slug" {
  description = "The unique URL slug for this project. If this is not provided a slug is automatically generated based on the name."
  type        = string
  default     = null
}

variable "platform" {
  description = "The integration platform."
  type        = string
  default     = "java-spring-boot"
}

variable "project_resolve_age" {
  description = "Hours in which an issue is automatically resolve if not seen after this amount of time."
  type        = string
  default     = null
}

variable "default_rules" {
  description = "Whether to create a default issue alert. Defaults to true where the behavior is to alert the user on every new issue."
  type        = bool
  default     = false
}

# sentry_key resource variables
variable "rate_limit_count_default" {
  description = "It is used if count key of key_rate_limits variable is not set. Default window is 60 seconds."
  type        = string
  default     = "5"
}

variable "rate_limit_window_default" {
  description = "It is used if window key of key_rate_limits variable is not set. Default window is 60 seconds."
  default     = "60"
}

variable "key_rate_limits" {
  description = "This variable holds Client keys(DSN) and rate limits. Key name is the name of the client key. Count is the event number, windows is the timeframe. Eg: key_rate_limits = {key1 = {count = \"10\", window = 60}}"
  type        = map(map(string))
  default = {
    prod = {
      count  = "20"
      window = "60"
    }
    dev = {
      count  = "5"
      window = "60"
    }
  }
}

# output variables
variable "print_keys" {
  description = "Print keys as clear text or masked"
  type        = bool
  default     = false
}
