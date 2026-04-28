# rgenda

醫院排班管理系統。原 skuld 專案的翻修版本，從 Django 3.0 / MySQL / Vue 2 升至 Django 4.2 LTS / PostgreSQL 16 / React 19（建置中）。

## Stack

| 層 | 技術 |
|---|---|
| Backend | Django 4.2 LTS + Python 3.12 + DRF 3.15 + drf-spectacular |
| Database | PostgreSQL 16 |
| Frontend | React 19 + Vite + Tailwind 4（建置中，目前主介面仍走 Django template） |
| Deploy | Docker Compose + Gunicorn + Nginx |

## Quick start

```bash
git clone https://github.com/ShihTsung/rgenda.git
cd rgenda

# 1. 建 .env（gitignored，本機專屬）
cp .env.example .env

# 編輯 .env，至少改三項：
#   SECRET_KEY=$(python3 -c "import secrets; print(secrets.token_hex(50))")
#   DB_PASSWORD=redfalcon
#   POSTGRES_PASSWORD=redfalcon

# 2.（選用）若本機 5432 port 被佔，建 override 不曝光 DB port
cat > docker-compose.override.yml <<'EOF'
services:
  db:
    ports: !reset []
EOF

# 3. 啟動
bash dev.sh
```

打開 <http://localhost/zh-hant/> 即可使用。

## 預設登入

| 用途 | 帳號 / 密碼 |
|---|---|
| Django app（瀏覽器、API） | `circlepen` / `circlepen` |
| PostgreSQL 角色 | `schedule_user` / `redfalcon` |

第一次啟動容器時，`db_init.sql` 會自動灌入測試資料：39 個 user、1 個部門、21 個班別、2711 個日曆日、1560 筆排班結果、6327 筆預排。

## 常用指令

```bash
# 啟動 / 停止
bash dev.sh
docker compose down

# 重新灌入 seed（會清空既有業務資料）
docker compose exec app python3 manage.py seed_initial --confirm

# 看 log
docker compose logs -f app

# 進 Django shell
docker compose exec app python3 manage.py shell

# 進 DB
docker exec -it postgresDB psql -U schedule_user schedule_db
```

## 部署

```bash
./deploy.sh --setup    # 首次部署（需要 .env）
./deploy.sh            # 後續更新
```

prod 與 dev 的差異見 `docker-compose.prod.yml`（不對外曝 DB port、log rotation）。

## 專案結構

```
rgenda/
├── schedule/                Django backend
│   ├── account/             帳號、部門、權限
│   ├── api/                 REST API（drf）
│   ├── date/                日曆與紅日設定
│   ├── demand/              人力需求
│   ├── mainpage/            首頁、報表、management commands
│   ├── notice/              公告
│   ├── remarks/             備註與方塊
│   ├── reservation/         預排假班
│   ├── result/              排班結果（含 pre/after/history）
│   ├── shift/               班別
│   ├── station/             工作站
│   └── schedule/            settings.py / urls.py
├── frontend/                React 19 + Vite（建置中）
├── nginxconf/               nginx 設定
├── db_init.sql              Postgres seed（public schema，含測試資料）
├── docker-compose.yml       主要 compose 設定
├── docker-compose.prod.yml  prod overlay
├── deploy.sh                部署腳本
└── dev.sh                   本機開發啟動腳本
```

## 本機備份（gitignored）

`backups/` 資料夾保留三種 dump（不入 git）：
- `full_<date>.sql` — 整個 DB 快照（含 roles）
- `db_schema_legacy_<date>.sql` — 原 MySQL 系統 `db.*` schema 考古檔（含 78 筆通知歷史、admin 操作 log）
- `public_dump_<date>.sql` — 乾淨 public-only dump

**換機時 copy 整個 `backups/`，不要 copy `postgres/`**（後者是 binary data dir，挑機器、挑版本）。

## 注意事項

- `.env` 本機專屬，**絕對別 commit**（已 gitignored）
- `postgres/` 是 docker volume 本地副產品，已 gitignored
- 原 `/init/` URL（無認證 wipe DB）和 `/mailtest`（公開 SMTP 觸發）已移除；初始化資料庫改用 `python manage.py seed_initial --confirm`
- React 前端目前未啟用，`location /` 會 302 到 `/zh-hant/` 走舊 Django template
