# Используем абсолютно пустой базовый образ
FROM scratch

# Аргумент для передачи версии Alpine
ARG ALPINE_VERSION
LABEL maintainer="Your Name"
LABEL description="Minimal Alpine Linux image built from rootfs"
LABEL alpine-version=$ALPINE_VERSION

# Добавляем корневую файловую систему Alpine (фиксированное имя)
ADD alpine-rootfs.tar.gz /

# Устанавливаем временную зону (опционально)
RUN echo "Europe/Moscow" > /etc/timezone

# Настраиваем репозитории
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories

# Обновляем индекс пакетов и устанавливаем базовые пакеты
RUN apk update && \
    apk add --no-cache ca-certificates tzdata busybox-extras && \
    rm -rf /var/cache/apk/*

# Создаем необходимые симлинки
RUN ln -sf /bin/busybox /bin/sh

# Рекомендуемые точки монтирования для совместимости с Docker
VOLUME /tmp
VOLUME /var/cache/apk

# Указываем оболочку по умолчанию
CMD ["/bin/sh"]
