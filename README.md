# Sentry Terraform Modules
This repository contains Terraform modules for Sentry

## Development
- Make development in new branch
- Update `CHANGELOG.md`file`
- Create Pull Request
- Push new tag

```
git fetch --all --tags
make [ next_patch | next_minor | next_major ]
git tag -a v1.0.1 -m "Add description for the feature"
git push --tags
```
