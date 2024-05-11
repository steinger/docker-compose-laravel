FROM php:8.3-fpm-alpine

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apk update && apk add libpng-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql gd zip calendar

RUN addgroup -g ${GID} --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel

RUN sed -i "s/user = www-data/user = laravel/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = laravel/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

USER laravel

RUN echo 'alias ll="ls -l"' >> ~/.ashrc
RUN echo 'alias la="ls -la"' >> ~/.ashrc
RUN echo 'alias art="php artisan"' >> ~/.ashrc
ENV ENV="/home/laravel/.ashrc"

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
