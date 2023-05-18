FROM nginx:1.24.0-alpine

ENV PHP_FPM_USER="http"
ENV PHP_FPM_GROUP="http"
ENV PHP_FPM_LISTEN_MODE="0660"
ENV PHP_MEMORY_LIMIT="512M"
ENV PHP_MAX_UPLOAD="50M"
ENV PHP_MAX_FILE_UPLOAD="200"
ENV PHP_MAX_POST="100M"
ENV PHP_DISPLAY_ERRORS="On"
ENV PHP_DISPLAY_STARTUP_ERRORS="On"
ENV PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
ENV PHP_CGI_FIX_PATHINFO=0
ENV TIMEZONE="America/Sao_Paulo"

RUN apk --no-cache --update add php-fpm libmcrypt \
    php-soap php-openssl php-gmp php-pdo_odbc \
    php-json php-dom php-pdo php-zip php-mysqli \
    php-sqlite3 php81-pecl-apcu php-pdo_pgsql php-bcmath \
    php-gd php-odbc php-pdo_mysql php-pdo_sqlite \
    php-gettext php-xmlreader php-bz2 \
    php-iconv php-pdo_dblib php-curl php-ctype tzdata supervisor

ADD dev.local.conf /etc/nginx/conf.d/default.conf
ADD *.sh /docker-entrypoint.d/


RUN mkdir /www && adduser -D -g 'http' http && chown -R http:http /www && \
    chmod 776 /docker-entrypoint.d/*.sh
    ##chown -R www:www /var/lib/nginx && \

EXPOSE 80
