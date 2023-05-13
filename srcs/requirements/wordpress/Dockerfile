FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache \
    curl            \
    tar             \
    php             \
    php-fpm         \
    php-cli         \
    php-phar        \
    php-openssl     \
    php-mysqli      \
    mariadb-client


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN addgroup -S wordpress && adduser -S -G wordpress wordpress

COPY ./tools/install_wordpress.sh /tools/install_wordpress.sh

COPY ./tools/launch.sh /tools/launch.sh
ENTRYPOINT sh /tools/launch.sh