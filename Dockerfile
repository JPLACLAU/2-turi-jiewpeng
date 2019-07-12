FROM ubuntu:16.04

RUN apt-get update &&\
    apt-get install -y \
    nginx \
    default-jdk

ENV SHINYPROXY_VERSION 1.0.0

ADD https://www.shinyproxy.io/downloads/shinyproxy-$SHINYPROXY_VERSION.jar /usr/app/shinyproxy/shinyproxy-$SHINYPROXY_VERSION.jar
COPY files/default /etc/nginx/sites-available/default
COPY files/default /etc/nginx/sites-enabled/default
COPY files/yourdomain.com.crt /etc/ssl/yourdomain.com.crt
COPY files/yourdomain.com.key /etc/ssl/yourdomain.com.key
COPY files/application.yml /usr/app/shinyproxy/application.yml

WORKDIR usr/app/shinyproxy

EXPOSE 8080

ENTRYPOINT service nginx reload && service nginx restart; java -jar shinyproxy-$SHINYPROXY_VERSION.jar