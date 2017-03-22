FROM nginx

MAINTAINER Daniel Brooks <dbrooks@klinche.com>


ENV URL symfony.dev
ENV APPFILE app.php

ADD symfony.conf /etc/nginx/sites-available/symfony.conf

RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]


