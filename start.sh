#!/bin/sh
# PIDファイルが存在する場合は削除
rm -f /app/tmp/pids/server.pid

bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0