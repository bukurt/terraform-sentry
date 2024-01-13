RED=\033[0;31m
NC=\033[0m # No Color

.SILENT: build
build:
	echo "Usage (Next major version): ${RED}make next_major${NC}"
	echo "Usage (Next minor version): ${RED}make next_minor${NC}"
	echo "Usage (Next patch version): ${RED}make next_patch${NC}"

.SILENT: test
test:
	./tools/test_terraform.sh
	docker run --rm -v $(shell pwd):/terraform hashicorp/terraform:1.6.6 fmt -recursive -check=true -diff=true /terraform/

.SILENT: deploy
deploy:
	echo "To be implemented"

.SILENT: dev_setup
dev_setup: .git/hooks/pre-push
	@pre-commit -V > /dev/null ||  (echo "pre-commit is not installed. Run brew install pre-commit or pip install pre-commit" && exit 1)
	pre-commit install

.SILENT: .git/hooks/pre-push
.git/hooks/pre-push:
	( cd .git/hooks && ln -s ../tools/githooks/pre-push )

.SILENT: next_major
next_major:
	./tools/git_tags.sh major

.SILENT: next_minor
next_minor:
	./tools/git_tags.sh minor

.SILENT: next_patch
next_patch:
	./tools/git_tags.sh patch
