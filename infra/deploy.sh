#!/bin/bash
set -e

WORKDIR=$(pwd)
docker build -t run-terraform .
docker images

docker run --rm -v "$WORKDIR":/workspace -w /workspace \
    --env-file "$(pwd)/.env" \
    run-terraform bash -c "
        terraform init &&
        terraform apply -target=module.container_registry.azurerm_resource_group.example -auto-approve &&
        terraform apply -target=module.container_registry.azurerm_container_registry.example -auto-approve
    "

ACR_USERNAME=$(docker run --rm -v "$WORKDIR":/workspace -w /workspace \
    --env-file "$(pwd)/.env" \
    run-terraform terraform output -raw acr_username | xargs)

echo "ACR_USERNAME_CLEAN: [$ACR_USERNAME]"
az acr login --name "$ACR_USERNAME" # --debug
ACR_PASSWORD=$(az acr credential show --name "$ACR_USERNAME" |jq .passwords.[0].value)
# echo $ACR_PASSWORD

cd .. && cd backend
pwd
docker build -t flask-pixel-app .
docker tag  flask-pixel-app "$ACR_USERNAME.azurecr.io/flask-pixel-app:latest"
docker push "$ACR_USERNAME.azurecr.io/flask-pixel-app:latest"

cd .. && cd infra
WORKDIR=$(pwd)
docker run --rm -v "$WORKDIR":/workspace -w /workspace \
    --env-file "$(pwd)/.env" \
    run-terraform bash -c "terraform apply -auto-approve -var=\"acr_username=$ACR_USERNAME\" -var=\"acr_password=$ACR_PASSWORD\""

