FROM php:8.1.8RC1-zts-alpine3.15

RUN apk add --update nodejs npm

RUN docker-php-ext-install pdo pdo_mysql sockets
RUN curl -sS https://getcomposer.org/installer​ | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


WORKDIR /app
COPY . .
RUN composer update
RUN composer install
CMD php artisan serve
