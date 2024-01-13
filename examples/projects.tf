module "example_project" {
  org          = var.org # your organization slug
  source       = "git@github.com:bukurt/terraform-sentry.git//modules/project?ref=v1.0.0"
  teams        = ["all-developers"]
  project_name = "example-project"
  platform     = "kotlin"
  key_rate_limits = {
    # 1st key.
    production = {
      window = "60" # seconds
      count  = "20" # number of events
    }
    # 2nd key.
    development = {
      window = "60"
      count  = "5"
    }
    # Add more keys if needed.
  }
}