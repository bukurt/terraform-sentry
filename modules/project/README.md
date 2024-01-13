# Sentry
Sentry Project Module

## Inputs

| Attributes | Description | Type | Required | Default |
| :--- | :--- | :---: | :---: |  :---: |
| organization | Name of organization | string| no | - |
| team | The owner team slug of the project. Find in https://<ORG_SLUG>.sentry.io/settings/teams/ | string | yes | N/A |
| project_name | Name of the project. It must fit into regex /[a-z]+[a-z0-9]+-?[a-z0-9]+/. E.g. my-proj, my-prod01, my01-proj2, myproj | string | yes | N/A |
| project_slug | The unique URL slug for this project. If this is not provided a slug is automatically generated based on the name. | string | no | null |
| platform | The integration platform. E.g. kotlin, java, python etc. Check https://sentry.io/platforms/ | string | yes | N/A |
| project_resolve_age | Hours in which an issue is automatically resolve if not seen after this amount of time. | string | no | null |
| key_rate_limits | Client keys(DSN) and rate limit parameters. Key name is the name of the client key. Eg: key_rate_limits = {key1 = {count = \"10\", window = 60}} | map(map(string)) | no | prod =  {<br />&nbsp;&nbsp;count = "20"<br />&nbsp;&nbsp;window = "60"<br />}<br />dev =  {<br />&nbsp;&nbsp;count = "5"<br />&nbsp;&nbsp;window = "60"<br />} |
| key_rate_limits.[each.key].count | Number of events | string | no | 5 |
| key_rate_limits.[each.key].window | Time windows in seconds | string | no | 60 |

## Usage
```
module "project_name" {
  source       = "git@gitref.git//sentry/project?ref=v5.7.0"
  teams        = ["all-developers"]   # teams should already be created in Sentry
  project_name = "my-project"
  platform     = "java-spring-boot"
  key_rate_limits = {
    # 1st key.
    prod = {
      window = "86400" # seconds
      count  = "5000"  # number of events
    }
    # 2nd key.
    staging = {
      window = "86400"
      count  = "100"
    }
    # Add more keys if needed.
  }
}

## Resources
https://registry.terraform.io/providers/jianyuan/sentry/latest/docs
