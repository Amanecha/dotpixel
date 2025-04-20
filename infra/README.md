### cd dotapp/infra
### docker build -t run-terraform .
### docker images
### docker run --rm -it -v $(pwd):/workspace -w /workspace run-terraform bash
### terraform login
### terraform init


az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
### paste .env
SP_OBJECT_ID=$(az ad sp show --id <client_id> --query id -o tsv)

az role assignment create \
  --assignee $SP_OBJECT_ID \
  --role "User Access Administrator" \
  --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>"

az role assignment create \
  --assignee $SP_OBJECT_ID \
  --role "Key Vault Certificates Officer" \
  --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.KeyVault/vaults/<keyvault-name>"

az role assignment create \
  --assignee $SP_OBJECT_ID \
  --role "Key Vault Administrator" \
  --scope /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.KeyVault/vaults/<keyvault-name>


### cd dotapp/infra
### ./deploy.sh
require docker deamon in local 
Create a container for running terraform
create azure container registory
login acr and get credential ## Create the env file in advance.
ACI release (backend app building, tagging , push registory)
And full infra release

### ./destroy.sh