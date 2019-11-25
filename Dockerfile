FROM php:7.2-fpm

# docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd pdo xml zip pdo_mysql opcache fileinfo exif intl curl iconv soap mysqli mbstring \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
