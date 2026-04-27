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

build_frontend() {
    echo "[1/2] 建置前端..."
    npm install
    npm run prod
    echo "      前端建置完成"
}

deploy_containers() {
    echo "[2/2] 部署容器..."
    docker-compose $COMPOSE_FILES pull db 2>/dev/null || true
    docker-compose $COMPOSE_FILES up -d --build
    echo "      容器部署完成"
    echo ""
    docker-compose $COMPOSE_FILES ps
}

setup() {
    if [ ! -f .env ]; then
        echo "錯誤: 找不到 .env 檔案"
        echo "請先複製 .env.example 並填入設定:"
        echo "  cp .env.example .env"
        exit 1
    fi
    echo "=== 首次部署 ==="
    build_frontend
    deploy_containers
    echo ""
    echo "=== 完成 ==="
    echo "開啟瀏覽器: http://你的IP"
    echo "初始化資料庫: 網址列輸入 /init"
}

case "${1:-}" in
    --setup)
        setup
        ;;
    --frontend-only)
        build_frontend
        echo "重新載入靜態檔案..."
        docker-compose $COMPOSE_FILES exec app python3 manage.py collectstatic --noinput
        ;;
    *)
        if [ ! -f .env ]; then
            echo "錯誤: 找不到 .env 檔案，首次部署請使用 ./deploy.sh --setup"
            exit 1
        fi
        build_frontend
        deploy_containers
        ;;
esac
