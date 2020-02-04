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
    && pecl install xdebug-2.9.2 \
    && docker-php-ext-enable xdebug \
    && echo "" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "[xdebug]" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_host = 'host.docker.internal'" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port = 9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable = 1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart = 0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back = 0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.default_enable = 1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
