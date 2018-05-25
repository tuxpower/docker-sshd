FROM alpine:latest

LABEL maintainer="https://github.com/hermsi1337"

ENV ROOT_PASSWORD root

RUN apk update	&& apk upgrade && apk add openssh \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
		&& echo "root:${ROOT_PASSWORD}" | chpasswd \
		&& mkdir -m 0700 -p ~/.ssh \
		&& rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
