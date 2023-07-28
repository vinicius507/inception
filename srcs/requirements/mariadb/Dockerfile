FROM debian:bullseye

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DATABASE
ARG MYSQL_ROOT_PASSWORD
  
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt update \
  && apt install -y curl \
  && curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | bash \
  && apt install -y mariadb-server mariadb-client \
  && apt clean \
  && rm -rf /var/lib/apt/list/* /tmp/* /var/tmp/*

RUN mkdir -p /var/lib/mysql /var/run/mysqld \
  && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
  && chmod 777 /var/run/mysqld

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf
COPY ./tools/setup_db.sh /tmp/setup_db.sh

RUN bash /tmp/setup_db.sh

HEALTHCHECK --start-period=5m \
  CMD mariadb -e 'SELECT @@datadir;' || exit 1

EXPOSE 3306

ENTRYPOINT ["mysqld_safe"]
