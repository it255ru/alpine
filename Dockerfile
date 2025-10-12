FROM scratch

ARG ALPINE_VERSION
LABEL maintainer="DevHellOps"
LABEL description="Minimal Alpine Linux image built from rootfs"
LABEL alpine-version=$ALPINE_VERSION

ADD alpine-rootfs.tar.gz /

# Настройка репозиториев (уже есть в rootfs, но на всякий случай)
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories

# Очистка кеша (пакеты УЖЕ установлены в rootfs)
RUN rm -rf /var/cache/apk/*

VOLUME /tmp
VOLUME /var/cache/apk
