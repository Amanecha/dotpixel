# ベースイメージ
FROM python:3.9-slim

# 作業ディレクトリの作成
WORKDIR /app

# 必要なパッケージをインストール
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションコードをコピー
COPY . /app

# Flask アプリケーションを起動する
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]