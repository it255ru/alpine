FROM scratch

ARG ALPINE_VERSION
LABEL maintainer="DevHellOps"
LABEL description="Minimal Alpine Linux image built from rootfs"
LABEL alpine-version=$ALPINE_VERSION

ADD alpine-rootfs.tar.gz /

RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories

# Обновляем индекс пакетов и устанавливаем базовые пакеты
RUN apk update && \
    apk add --no-cache && \
    rm -rf /var/cache/apk/*

# Рекомендуемые точки монтирования для совместимости с Docker
VOLUME /tmp
VOLUME /var/cache/apk
