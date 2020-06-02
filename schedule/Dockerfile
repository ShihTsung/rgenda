# Pull the base image
FROM python:3.7

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /code
RUN mkdir /code/schedule
WORKDIR /code/schedule
#Upgrade pip
RUN pip install pip -U
RUN pip install --upgrade setuptools
RUN apt-get update
RUN apt-get install python3-dev default-libmysqlclient-dev gcc cron vim -y
RUN pip install mysqlclient uwsgi
ADD . /code/schedule

#Install dependencies
RUN pip install -r requirements.txt
