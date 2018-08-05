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
RUN pip install -r requirements.txt
RUN django-admin startproject ${PROJECT}
## ADD ./myproject /myproject/myproject
WORKDIR /${PROJECT}

# Server
 EXPOSE 8000
 STOPSIGNAL SIGINT
 ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]
