FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y gnupg less libfcgi-bin lsb-release wget \
  && mkdir -p /etc/apt/keyrings \
  && wget -qO /etc/apt/keyrings/sury.pgp https://packages.sury.org/php/apt.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/sury.pgp] https://packages.sury.org/php $(lsb_release -sc) main" \
    | tee /etc/apt/sources.list.d/php.list \
  && apt update \
  && apt install -y php8.2 php8.2-fpm php8.2-mysql

RUN mkdir -p /var/run/php \
  && chown www-data:www-data /var/run/php \
  && chmod 755 /var/run/php

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN mkdir -p /var/www/adminer \
  && wget -qO /var/www/adminer/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
  && chown -R www-data:www-data /var/www/adminer \
  && find /var/www/adminer -type d -exec chmod 755 {} \; \
  && find /var/www/adminer -type f -exec chmod 644 {} \;

EXPOSE 8000

STOPSIGNAL SIGQUIT

ENTRYPOINT ["php-fpm8.2", "-F"]
