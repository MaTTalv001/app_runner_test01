# ベースイメージの指定
FROM --platform=linux/x86_64 ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y build-essential default-mysql-client

# 作業ディレクトリの設定
WORKDIR /app

# 環境変数の設定
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE
ENV RAILS_ENV=production

# GemfileとGemfile.lockをコンテナ内にコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Bundlerを使ってRuby gemsをインストール
RUN bundle install

# ホストのファイルをコンテナ内の作業ディレクトリにコピー
COPY . /app

# アセットプリコンパイル
RUN rails assets:precompile

# スタートアップスクリプトをコンテナ内にコピーし、実行権限を設定
COPY start.sh /start.sh
RUN chmod 744 /start.sh

# コンテナ起動時に実行されるコマンド
CMD ["sh", "/start.sh"]
