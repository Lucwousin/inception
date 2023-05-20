FROM alpine:3.16

ARG GID=1001
ARG UID=1000
ARG GIT_PASSWORD
ARG DOMAIN_NAME
RUN apk add --no-cache openssh git && \
    addgroup --system --gid "$GID" git && \
    adduser --ingroup git --uid "$UID" \
            --shell `which git-shell`  \
            --disabled-password \
            --home /git --gecos git \
            git && \
    echo "git:$GIT_PASSWORD" | chpasswd git && \
    ssh-keygen -A &&  \
    find /etc/ssh -not -name "*.pub" -exec ssh-keygen -c -C "root@$DOMAIN_NAME" -f "{}" ";"

USER git
RUN ssh-keygen -f ~/.ssh/id_rsa -C git@$DOMAIN_NAME -N ""

ENTRYPOINT ["/usr/sbin/sshd", "-D"]