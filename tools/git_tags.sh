#!/bin/bash

function parse_tags() {
    VERSION=$1
    VERSION="${VERSION#[vV]}"
    VERSION_MAJOR="${VERSION%%\.*}"
    VERSION_MINOR="${VERSION#*.}"
    VERSION_MINOR="${VERSION_MINOR%.*}"
    VERSION_PATCH="${VERSION##*.}"

    echo "Current tag: v${VERSION}"
}

function get_next_major() {
    VERSION_MAJOR=$(( VERSION_MAJOR + 1))
    echo "Next tag: v${VERSION_MAJOR}.0.0"
}

function get_next_minor() {
    VERSION_MINOR=$(( VERSION_MINOR + 1))
    echo "Next tag: v${VERSION_MAJOR}.${VERSION_MINOR}.0"
}

function get_next_patch() {
    VERSION_PATCH=$(( VERSION_PATCH + 1))
    echo "Next tag: v${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
}

CHANGE_TYPE=$1
CURRENT_TAG=$(git tag | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -1)

if [[ $CHANGE_TYPE = "patch" ]]
then
    parse_tags $CURRENT_TAG
    get_next_patch
elif [[ $CHANGE_TYPE = "minor" ]]
then
    parse_tags $CURRENT_TAG
    get_next_minor
elif [[ $CHANGE_TYPE = "major" ]]
then
    parse_tags $CURRENT_TAG
    get_next_major
else
    echo "Unknown change type"
fi
