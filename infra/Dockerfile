# ベースとなるイメージを指定
FROM ubuntu:20.04

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl

# Terraformのバージョンを指定
ENV TERRAFORM_VERSION=1.11.2

# Terraformのインストール
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin/ && \
    rm /tmp/terraform.zip

# Terraformのバージョン確認
RUN terraform --version

# 作業ディレクトリを指定
WORKDIR /workspace

# コンテナ起動時に実行するコマンド
CMD ["terraform"]