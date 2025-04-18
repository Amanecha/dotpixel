### "build_dev.yml" is building ../frontend/
### "deploy_dev.yml" is deploy to Azure AppService ../frontend/


# create service principal for Azure login
az ad sp create-for-rbac --name "<new sp name>" --role contributor \
  --scopes /subscriptions/<subscriptionID> \
  --sdk-auth
## paste json into github Actions secrets and variables
## AZURE_CREDENTIALS on Repository secrets

