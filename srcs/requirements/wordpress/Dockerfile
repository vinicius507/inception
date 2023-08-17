FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y gnupg less libfcgi-bin lsb-release wget \
  && mkdir -p /etc/apt/keyrings \
  && wget -qO /etc/apt/keyrings/sury.pgp https://packages.sury.org/php/apt.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/sury.pgp] https://packages.sury.org/php $(lsb_release -sc) main" \
    | tee /etc/apt/sources.list.d/php.list \
  && apt update \
  && apt install -y mariadb-client php8.2 php8.2-curl php8.2-fpm php8.2-iconv php8.2-mysql php8.2-redis php8.2-zip

RUN mkdir -p /var/run/php \
  && chown www-data:www-data /var/run/php \
  && chmod 755 /var/run/php

RUN mkdir -p /var/www/wordpress \
  && wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod u+x /usr/local/bin/wp \
  && wp cli update \
  && wp core download --path=/var/www/wordpress --allow-root

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /var/www/wordpress/wp-config.php
COPY ./tools/entrypoint.sh .

RUN chmod u+x ./entrypoint.sh

EXPOSE 9000

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint.sh"]