FROM alpine:3.16

RUN apk update && apk add --no-cache \
    curl            \
    tar             \
    php             \
    php-fpm         \
    php-cli         \
    php-phar        \
    php-openssl     \
    php-mysqli      \
    php-iconv       \
    mariadb-client


RUN curl --output /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod a+x /usr/local/bin/wp

# 1001 seems to be a reasonable default? Just build with makefile tbh
ARG GID=1001
ARG UID=1000
RUN addgroup --system --gid "$GID" wp_pool && \
    adduser --system --uid "$UID" wp_pool --gecos "" --ingroup wp_pool wp_pool && \
    rm -f /etc/php8/php-fpm.d/www.conf

COPY ./tools/launch.sh /tools/launch.sh

ENTRYPOINT ["/tools/launch.sh"]
