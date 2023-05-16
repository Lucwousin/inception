FROM alpine:3.16

# set mariadb default perms so we can remove the db whenever we want
ENV UMASK=0660 UMASK_DIR=0770

# 1001 seems to be a reasonable default? Just build with makefile tbh
ARG GID=1001
# Add group/user with correct gid BEFORE apk adds it
RUN addgroup --system --gid "$GID" mysql && \
    adduser --system --gecos mysql --ingroup mysql --home /var/lib/mysql mysql && \
    apk add --no-cache mariadb && rm -rf /var/cache

COPY ./tools/launch.sh /tools/launch.sh

ENTRYPOINT ["/tools/launch.sh"]
