FROM php:7.1.23-fpm-stretch as php-fpm
ADD sources.list /etc/apt/

RUN set -ex; \
    # 换源
    echo "deb http://mirrors.aliyun.com/debian/ stretch main contrib non-free" > /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    # 更新源
    apt-get update; \
    apt-get install -y \
        git \
        vim \
        # php-gd 的依赖
        libfreetype6-dev \
        libpng-dev \
        libjpeg-dev \
        # php-zip 的依赖
        libzip-dev \
        # php-memcached 的依赖
        libmemcached-dev \
        ; \
    docker-php-ext-configure bcmath; \
    docker-php-ext-configure gd \
        --with-gd \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
        --with-freetype-dir=/usr/include \
        ; \
    docker-php-ext-configure opcache --enable-opcache; \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql; \
    docker-php-ext-configure zip --with-zip-dir=/usr/include; \
    docker-php-ext-configure mysqli; \
    docker-php-ext-install -j $(nproc) \
        bcmath \
        gd \
        pdo_mysql \
        zip \
        mysqli \
        opcache \
        ; \
    pecl install http://dev-tmp.banshouhui.com/xdebug-2.9.5.tgz; \
    docker-php-ext-enable xdebug; \
    pecl install http://dev-tmp.banshouhui.com/mongodb-1.7.4.tgz; \
    docker-php-ext-enable mongodb; \
    pecl install http://dev-tmp.banshouhui.com/redis-5.3.2.tgz; \
    docker-php-ext-enable redis; \
    pecl install http://dev-tmp.banshouhui.com/memcached-3.1.5.tgz; \
    docker-php-ext-enable memcached; \
    chown -Rc www-data:www-data /var/www;

WORKDIR /app

CMD ["php-fpm"]


FROM php-fpm

#nodejs cnpm bower
RUN set -ex; \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - ;\
    apt-get install -y nodejs; \
    npm install -g cnpm --registry=https://registry.npm.taobao.org; \
    cnpm install -g bower;

USER www-data



