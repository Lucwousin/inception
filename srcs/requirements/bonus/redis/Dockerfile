FROM alpine:3.16

RUN apk add --no-cache redis

ENTRYPOINT ["redis-server", "/etc/redis/redis.conf"]
