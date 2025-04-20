#!/bin/bash
set -e
set -a
source "$(pwd)/.env"
set +a

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout appgw.key -out appgw.crt -subj "/CN=dotapp-front-domain.japaneast.cloudapp.azure.com"
openssl pkcs12 -export  -out appgw.pfx -inkey appgw.key -in appgw.crt -password pass:$CERT_PASSWORD
ENCODED_PFX=$(base64 < appgw.pfx)
if ! grep -q "ssl_cert_data" terraform.tfvars ; then
  echo $ENCODED_PFX >>terraform.tfvars
fi

# cat <<EOF >> terraform.tfvars
# ssl_cert_data = "$ENCODED_PFX"
# EOF

WORKDIR=$(pwd)
docker run --rm -v "$WORKDIR":/workspace -w /workspace \
  --env-file "$(pwd)/.env" \
  run-terraform bash -c "
    terraform init &&
    terraform apply -target=module.keyvault -auto-approve
  "

az login --service-principal \
  --username "$ARM_CLIENT_ID" \
  --password "$ARM_CLIENT_SECRET" \
  --tenant "$ARM_TENANT_ID" 

# az keyvault certificate import \
#   --vault-name "$KEYVAULT_NAME" \
#   --name "$CERT_NAME" \
#   --file appgw.pfx \
#   --password "$CERT_PASSWORD"

docker run --rm -v "$WORKDIR":/workspace -w /workspace \
  --env-file "$(pwd)/.env" \
  mcr.microsoft.com/azure-cli bash -c "
    az login --service-principal --username \"$ARM_CLIENT_ID\" --password \"$ARM_CLIENT_SECRET\" --tenant \"$ARM_TENANT_ID\" &&
    az account show &&
    az keyvault certificate import \
      --vault-name \"$KEYVAULT_NAME\" \
      --name \"$CERT_NAME\" \
      --file appgw.pfx \
      --password \"$CERT_PASSWORD\"
  "

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

