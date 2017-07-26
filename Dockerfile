FROM php:7-fpm-alpine

MAINTAINER Wilton Garcia <wiltonog@gmail.com>

RUN apk add --no-cache --virtual .build-deps build-base curl git \
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
    && docker-php-ext-install -j$(nproc) bz2 iconv mcrypt mbstring pdo_mysql mysqli pgsql pdo_pgsql zip curl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install MongoDB
RUN pecl install mongodb && docker-php-ext-enable mongodb

# Install Redis
RUN pecl install redis && docker-php-ext-enable redis

RUN adduser -D -u 1000 php

