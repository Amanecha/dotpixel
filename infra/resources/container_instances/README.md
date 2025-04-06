az container show --resource-group <resouce group> --name <container group> --query "ipAddress.ip"
az container exec --name <container group> --resource-group <resouce group> --exec-command "/bin/sh"
curl -F "file=@yourpath” http://<public_ip>:5000/upload