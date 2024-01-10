FROM php:8.2.1-fpm-alpine

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_MEMORY_LIMIT -1

RUN apk update && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
        git \
    	zip \
        unzip \
        curl \
    	icu-dev \
        libpq-dev \
    	imagemagick-dev \
    	libzip-dev && \
    docker-php-ext-install zip pdo pdo_pgsql pgsql pdo_mysql intl exif && \
    pecl install  -o -f imagick && \
	docker-php-ext-enable imagick && \
	#apk del .build-deps && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
