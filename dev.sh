#!/bin/bash
# 開發模式：Docker (Django + DB + nginx)
# 使用方式：bash dev.sh
#
# 註：React 前端尚未完成。需要時再到 frontend/ 自行 `npm run dev`。

set -e

echo ">>> 啟動 Docker 服務..."
docker compose up -d

echo ">>> 等待 Django 就緒..."
# /api/auth/me/ 未帶 token 應回 401，代表 Django + DRF 都起來了
until curl -s -o /dev/null -w "%{http_code}" http://localhost/api/auth/me/ | grep -q "401"; do
  sleep 2
done
echo "    Django OK — http://localhost/"
