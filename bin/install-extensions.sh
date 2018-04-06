#! /bin/sh

set -eo pipefail

apk --no-cache add \
        libjpeg-turbo-dev \
        freetype \
        freetype-dev \
        libmcrypt-dev \
        libpng-dev \
        curl-dev \
        icu-dev \
        libxml2-dev \
        autoconf \
        g++ \
        imagemagick-dev \
        libtool \
        make \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
    && docker-php-ext-install  \
        iconv \
        mcrypt \
        gd \
        bcmath \
        curl \
        intl \
        json \
        mbstring \
        xml \
        soap \
        opcache \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del autoconf g++ libtool make \
