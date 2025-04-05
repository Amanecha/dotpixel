az acr login --name <ACR_NAME>
cd backend
docker build -t flask-pixel-app .
docker tag flask-pixel-app:latest <ACR_NAME>.azurecr.io/flask-pixel-app:mmdd_num
docker push <ACR_NAME>.azurecr.io/flask-pixel-app:mmdd_num

az acr credential show --name <ACR_NAME>