#!/bin/bash

npm install
npm run prod
docker exec -i schedule_web python manage.py collectstatic --noinput --clear
