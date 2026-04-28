#!/bin/bash
set -e

# ============================================================
# 部署腳本
# 使用方式:
#   首次部署:  ./deploy.sh --setup
#   一般更新:  ./deploy.sh
#   僅前端:    ./deploy.sh --frontend-only
# ============================================================

COMPOSE_FILES="-f docker-compose.yml -f docker-compose.prod.yml"

# React 前端尚未完成，本腳本目前只處理 Django 容器部署。
# 待 React 接手後，此處再加 `cd frontend && npm ci && npm run build`。

deploy_containers() {
    echo "部署容器..."
    docker compose $COMPOSE_FILES pull db 2>/dev/null || true
    docker compose $COMPOSE_FILES up -d --build
    echo "容器部署完成"
    echo ""
    docker compose $COMPOSE_FILES ps
}

require_env() {
    if [ ! -f .env ]; then
        echo "錯誤: 找不到 .env 檔案"
        echo "請先複製 .env.example 並填入設定:"
        echo "  cp .env.example .env"
        exit 1
    fi
}

case "${1:-}" in
    --setup)
        require_env
        echo "=== 首次部署 ==="
        deploy_containers
        echo ""
        echo "=== 完成 ==="
        echo "開啟瀏覽器: http://你的IP"
        echo "初始化資料庫種子: docker compose exec app python3 manage.py seed_initial --confirm"
        ;;
    *)
        require_env
        deploy_containers
        ;;
esac
