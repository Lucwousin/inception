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
# The sed command sets the php-fpm error log to stderr, so we don't have to deal with perms
RUN addgroup --system --gid "$GID" wp_pool && \
    adduser --system --uid "$UID" wp_pool --gecos "" --ingroup wp_pool wp_pool && \
    rm -f /etc/php8/php-fpm.d/www.conf && \
    sed -i -E 's/;?error_log = .*/error_log = \/dev\/stderr/1' /etc/php8/php-fpm.conf

COPY ./tools/launch.sh /tools/launch.sh

# Make sure we can actually remove the files we create inside the volume
USER wp_pool
WORKDIR /data/wordpress
ENTRYPOINT ["/tools/launch.sh"]
