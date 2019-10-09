#!/usr/bin/env bash

function main() {
  docker run \
    -it \
    -v "${HOME}/.aws:/custodian/.aws:ro" \
    -v "${PWD}/logs:/tmp" \
    -v "${PWD}/.cache:/custodian/.cache" \
    -v "${PWD}/policies:/custodian/policies:ro" \
    einyx/cloud-custodian run --output-dir=/tmp \
    policies/policy.yml
}

main
