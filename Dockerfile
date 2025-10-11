# Этап 1: Базовый образ из minirootfs
FROM scratch AS base

# Добавляем корневую файловую систему
ADD alpine-minirootfs-3.20.2-x86_64.tar.gz /

# Устанавливаем временную зону (опционально)
RUN echo "Europe/Moscow" > /etc/timezone

# Этап 2: Настройка базовой системы
FROM base AS configured

# Настраиваем репозитории для установки пакетов
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories

# Обновляем индекс пакетов
RUN apk update

# Этап 3: Установка необходимых пакетов безопасности
FROM configured AS secured

# Устанавливаем только критически важные пакеты
RUN apk add --no-cache \
    ca-certificates \
    tzdata \
    busybox-extras

# Очищаем кеш apk для уменьшения размера
RUN rm -rf /var/cache/apk/*

# Этап 4: Финальная настройка
FROM secured AS final

# Создаем необходимые симлинки
RUN ln -sf /bin/busybox /bin/sh

# Устанавливаем точку входа
CMD ["/bin/sh"]
