FROM alpine:3.18
LABEL maintainer="tiagomoreira317@gmail.com"
RUN apk add --no-cache openssh bash sshpass
ADD entrypoint.sh /entrypoint.sh
WORKDIR /github/workspace
ENTRYPOINT /bin/bash /entrypoint.sh
