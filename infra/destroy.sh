#!/bin/bash
set -e

WORKDIR=$(pwd)
docker build -t run-terraform .
docker images

docker run --rm -v "$WORKDIR":/workspace -w /workspace \
    --env-file "$(pwd)/.env" \
    run-terraform bash -c "
        terraform init &&
        terraform destroy -auto-approve
    "