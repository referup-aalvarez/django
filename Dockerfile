# My Site
# Version: 1.0
FROM python:3
# Install Python and Package Libraries
RUN apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
RUN apt-get install -y \
    libffi-dev \
    libssl-dev \
    default-libmysqlclient-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    net-tools \
    vim
# Project Files and Settings
ARG PROJECT=myproject
COPY requirements.txt .
RUN pip3 install psycopg2
RUN pip install -r requirements.txt
RUN pip3 install psycopg2-binary
RUN django-admin startproject ${PROJECT}
WORKDIR /${PROJECT}
COPY entry.sh /root
RUN chmod +x /root/entry.sh
# Server
 EXPOSE 8000
 STOPSIGNAL SIGINT
ENTRYPOINT ["/root/entry.sh"]
