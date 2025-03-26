cd dotapp/infra
docker build -t run-terraform .
docker images
docker run --rm -it -v $(pwd):/workspace -w /workspace run-terraform bash
terraform login

