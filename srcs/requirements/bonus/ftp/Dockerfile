FROM alpine:3.16

ARG GID=1001
ARG UID=1000
ARG FTP_USER
ARG FTP_PASSWORD
RUN apk add --no-cache vsftpd && \
    addgroup --system --gid "$GID" "$FTP_USER" && \
    adduser --system --uid "$UID" --gecos "" --ingroup "$FTP_USER" "$FTP_USER" && \
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd &&  \
    touch /var/log/vsftpd.log && chmod a+rw /var/log/vsftpd.log && \
    echo "$FTP_USER" > /etc/vsftpd/vsftpd.userlist

# Can not use configs in the compose file for this, as it needs to be owned by root
# and the uid/gid options in configs do not work
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/launch.sh /tools/launch.sh

ENTRYPOINT ["/tools/launch.sh"]
