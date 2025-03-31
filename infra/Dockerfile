FROM ubuntu:20.04

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    gnupg \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/* 

# Terraformのバージョンを指定
ENV TERRAFORM_VERSION=1.11.2

# Terraformのインストール
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin/ && \
    rm /tmp/terraform.zip

# Terraformのバージョン確認
RUN terraform --version

# Azure CLI のインストール
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    az extension add --name resource-graph --yes && \
    az extension add --name connectedk8s --yes

RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc > /etc/apt/trusted.gpg.d/microsoft.asc && \
    apt-add-repository https://packages.microsoft.com/ubuntu/20.04/prod && \
    apt-get update && \
    apt-get install -y aztfexport && \
    rm -rf /var/lib/apt/lists/*
# 作業ディレクトリを指定
WORKDIR /workspace

# コンテナ起動時に実行するコマンド
CMD ["terraform"]
