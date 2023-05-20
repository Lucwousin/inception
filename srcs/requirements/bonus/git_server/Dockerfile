FROM alpine:3.16

ARG GID=1001
ARG UID=1000
ARG GIT_PASSWORD
RUN apk add --no-cache git openssh-server && \
    addgroup --system --gid "$GID" git && \
    adduser --shell `which git-shell`  \
            --ingroup git --uid "$UID" \
            --disabled-password git



ENTRYPOINT ["top", "-b"]