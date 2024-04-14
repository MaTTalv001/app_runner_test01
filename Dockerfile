# ベースイメージの指定
FROM ruby:3.1.0

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y build-essential default-mysql-client

# 作業ディレクトリの設定
WORKDIR /app

# GemfileとGemfile.lockをコンテナ内にコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Bundlerを使ってRuby gemsをインストール
RUN bundle install

# ホストのファイルをコンテナ内の作業ディレクトリにコピー
COPY . /app

# スタートアップスクリプトをコンテナ内にコピーし、実行権限を設定
COPY start.sh /start.sh
RUN chmod 744 /start.sh

# コンテナ起動時に実行されるコマンド
CMD ["sh", "/start.sh"]