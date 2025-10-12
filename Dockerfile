FROM scratch

ARG ALPINE_VERSION
LABEL maintainer="DevHellOps" 
LABEL description="Ultra-minimal Alpine Linux - apk removed"
LABEL alpine-version=$ALPINE_VERSION

ADD alpine-rootfs.tar.gz /

# Удаляем apk чтобы исключить установку пакетов в runtime
RUN rm -rf \
    /etc/apk/ \
    /usr/sbin/apk \
    /lib/apk/ \
    /var/cache/apk/

VOLUME /tmp

CMD ["/bin/sh"]
