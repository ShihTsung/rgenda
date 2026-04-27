#!/bin/bash
# 開發模式：Docker (Django + DB + nginx) + Vite dev server
# 使用方式：bash dev.sh

set -e

echo ">>> 啟動 Docker 服務..."
docker compose up -d

echo ">>> 等待 Django 就緒..."
until curl -s -o /dev/null -w "%{http_code}" http://localhost/api/auth/login/ | grep -q "405"; do
  sleep 2
done
echo "    Django OK"

echo ">>> 啟動 Vite dev server (http://localhost:5173)"
cd frontend && npm run dev
