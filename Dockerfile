FROM php:7-fpm-alpine

MAINTAINER Wilton Garcia <wiltonog@gmail.com>

RUN apk add --no-cache --virtual .build-deps build-base curl git autoconf \
    freetype-dev \
    libjpeg-turbo-dev \
    postgresql-dev \
    imagemagick-dev \
    libmcrypt-dev \
    libpng-dev \
    libmemcached-dev \
    openssl-dev \
    libsasl \
    zlib-dev \
    libcurl \
    curl-dev \
    bzip2-dev \
    && docker-php-ext-install bz2 iconv mcrypt mbstring pdo_mysql mysqli pgsql pdo_pgsql zip curl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install Redis
RUN pecl install redis && docker-php-ext-enable redis

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache --virtual .build-deps shadow \
    && usermod -d /var/www/html -u 1000 www-data \
    && groupmod -g 50 www-data \
    && find / -group 82 -exec chgrp -h www-data {} \; \
    && find / -user 82 -exec chown -h www-data {} \;



