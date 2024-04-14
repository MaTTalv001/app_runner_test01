#!/bin/sh
# PIDファイルが存在する場合は削除
rm -f /app/tmp/pids/server.pid

# 環境変数 RUN_MIGRATIONS が true に設定されている場合のみマイグレーションを実行
if [ "$RUN_MIGRATIONS" = "true" ]; then
  echo "Running migrations..."
  bundle exec rails db:migrate
else
  echo "Skipping migrations..."
fi

echo "Starting the server..."

bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0