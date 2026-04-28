FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /code/schedule

# libpq-dev 是 psycopg2 編譯所需的 PostgreSQL 客戶端函式庫
# gettext 是 Django compilemessages 所需
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    gcc \
    gettext \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools
RUN pip install gunicorn

# 先複製 requirements 以利用 Docker layer cache
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
