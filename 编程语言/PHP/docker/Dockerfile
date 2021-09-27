FROM php:7.4-alpine3.13

RUN echo -e http://mirrors.ustc.edu.cn/alpine/v3.7/main/ >> /etc/apk/repositories
RUN apk update
# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    postgresql-dev \
    sqlite-dev

# Install production dependencies
RUN apk add --no-cache \
    bash \
    curl \
    freetype-dev \
    g++ \
    gcc \
    git \
    icu-dev \
    icu-libs \
    imagemagick \
    libc-dev \
    libjpeg-turbo-dev \
    libpng \
    libpng-dev \
    libzip-dev \
    make \
    mysql-client \
    nodejs \
    npm \
    oniguruma-dev \
    yarn \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev \
    zip \
    libmcrypt-dev \
    libxml2-dev \
    libmemcached-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev 

# Install PECL and PEAR extensions
RUN pecl install \
    redis \
    imagick \
    xdebug

# Enable PECL and PEAR extensions
RUN docker-php-ext-enable \
    redis \
    imagick \
    xdebug

# Install php extensions
RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    exif \
    gd \
    iconv \
    intl \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pcntl \
    soap \
    tokenizer \
    xml \
    zip

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# 指定composer国内镜像源
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /opt/server
COPY . /opt/server/
CMD bash -c "composer install && php artisan serve --host 0.0.0.0 --port 8000"
