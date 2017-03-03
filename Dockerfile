FROM debian:jessie

MAINTAINER Daniel Brooks <dbrooks@klinche.com>

RUN apt-get update && apt-get install -y \
    nginx

ENV URL symfony.dev
ENV APPFILE app.php


ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/

RUN sed -i -e 's/APPFILE/${APPFILE}/g' /etc/nginx/sites-available/symfony.conf
RUN sed -i -e 's/URL/${URL}/g' /etc/nginx/sites-available/symfony.conf


RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
