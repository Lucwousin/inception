FROM alpine:3.16

ARG GID=1001
ARG UID=1000
RUN apk add --no-cache vsftpd && \
    addgroup --system --gid "$GID" "$FTP_USER" && \
    adduser --system --uid "$UID" "$FTP_USER" --gecos "" --ingroup "$FTP_USER" "$FTP_USER" && \
    echo "$FTP_PASSWORD" | passwd ftp

ENTRYPOINT ["vsftpd"]