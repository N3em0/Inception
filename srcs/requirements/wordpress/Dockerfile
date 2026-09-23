FROM alpine:3.23

RUN apk add --no-cache \
iputils-ping net-tools \
wget \
tar \
gzip \
php85-zlib \
php85-fpm \
php85-mysqli \
php85-cli \
php85-phar \
php85-mbstring \
php85-curl \
netcat-openbsd \
mariadb-client
# php85-fpm      : Process manager, Handle PHP requests from Nginx, to generate Wordpress pages
# php85-mysqli   : Allow for PHP to connect and format queries for mysql database
# php85-cli      : Archive module for WP-CLI
# php85-phar     : Read .phar PHP archives
# php85-mbstring : Special characters
# php85-curl     : Allow PHP(Wordpress) to navigate web and download
# mariadb-client : Ping mariadb to check if its done installing
# netcat-openbsd : Allow to ping wordpress port for dockercompose healthcheck

RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php85/php-fpm.d/www.conf
RUN echo "clear_env = no" >> /etc/php85/php-fpm.d/www.conf
RUN ln -s /usr/bin/php85 /usr/bin/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY tools/wordpress.sh  /bin/wordpress.sh

EXPOSE 9000

RUN chmod +x /bin/wordpress.sh

ENTRYPOINT ["/bin/wordpress.sh"]

# FROM debian:bookworm-slim
#
# RUN apt-get update -y && \
# apt-get install -y --no-install-recommends \
# iputils-ping net-tools \
# wget \
# php8.2-fpm \
# php8.2-mysql \
# php8.2-cli \
# mariadb-client
#
# RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf
# RUN echo "clear_env = no" >> /etc/php/8.2/fpm/pool.d/www.conf

