FROM php:7.4-fpm as php-fpm
LABEL version="7.4"

WORKDIR /app

EXPOSE 9000
EXPOSE 8080

#更新源,源必须和系统版本对应,安装aptitude
ADD sources.list /etc/apt/sources.list

#COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN set -ex; \
    apt-get update; \
    apt-get install -y aptitude; \
    aptitude install -y \
      vim \
      curl \
      git \
      zip \
      unzip \
    #依赖
      libbz2-dev \
      zlib1g-dev \
      libpng-dev \
      libzip-dev \
      libjpeg-dev \
      libfreetype6-dev \
      libmemcached-dev \
      libc-client-dev \
      libkrb5-dev \
      libonig-dev; \

    #配置拓展并安装
    docker-php-ext-configure gd; \
    docker-php-ext-install -j $(nproc) \
        gd \
        opcache \
        pdo_mysql \
        gettext \
        sockets \
        ; \

    #安装并开启拓展
    pecl install swoole \
      xdebug \
      mongodb \
      redis \
      memcached; \
    docker-php-ext-enable xdebug \
      mongodb \
      redis \
      memcached; \
    chown -Rc www-data:www-data /var/www;

#安装composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer;
ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1


#安装nodejs cnpm bower
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - ;\
    aptitude install -y nodejs; \
    npm install -g cnpm --registry=https://registry.npm.taobao.org; \
    cnpm install -g bower;


CMD ["php-fpm"]

FROM php-fpm