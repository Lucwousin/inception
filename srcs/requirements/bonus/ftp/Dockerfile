FROM alpine:3.16

ARG GID=1001
ARG UID=1000
ARG FTP_USER
ARG FTP_PASSWORD
RUN apk add --no-cache vsftpd && \
    addgroup --system --gid "$GID" "$FTP_USER" && \
    adduser --system --uid "$UID" --gecos "" --ingroup "$FTP_USER" "$FTP_USER" && \
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

ENTRYPOINT ["vsftpd", "/etc/vsftpd.conf"]
