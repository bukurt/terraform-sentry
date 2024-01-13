#!/bin/bash

# Get the repository absolute path
REPO_ROOT_DIR=$(git rev-parse --show-toplevel)
if [ -z "$REPO_ROOT_DIR" ]
then
  REPO_ROOT_DIR=$(pwd)
fi

function test_changelog_update() {
    CHANGED_FILES=$(git diff --name-only $(git rev-parse origin/master))
    IFS=$' '
    CHANGED_FILES=($CHANGED_FILES)
    if [[ " ${CHANGED_FILES[@]} " =~ "CHANGELOG.md" ]]; then
        echo "Changelog updated"
    else
        echo "No changes detected in CHANGELOG.md"
        exit 1
    fi
}

test_changelog_update
