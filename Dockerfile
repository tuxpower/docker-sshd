FROM alpine:latest

LABEL maintainer="https://github.com/hermsi1337"

ENV ROOT_PASSWORD root

RUN apk update  && apk upgrade && apk add curl bind-tools busybox-extras dig iputils netcat-openbsd nmap openssh tcpdump socat \
                    postgresql-client bash mongodb \
                && sed -i s/#PermitRootLogin.*/PermitRootLogin\ without-password/ /etc/ssh/sshd_config \
                && sed -i s/#PermitTunnel.*/PermitTunnel\ yes/ /etc/ssh/sshd_config \
                && echo "root:${ROOT_PASSWORD}" | chpasswd \
                && mkdir -m 0700 -p ~/.ssh \
                && rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
