FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache mariadb
COPY ./tools/launch.sh /tools/launch.sh

RUN mkdir /run/mysqld && chown -R mysql:mysql /run/mysqld

ENTRYPOINT sh /tools/launch.sh
