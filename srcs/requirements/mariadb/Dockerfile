FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt update \
  && apt install -y curl \
  && curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | bash \
  && apt install -y mariadb-server mariadb-client \
  && apt clean \
  && rm -rf /var/lib/apt/list/* /tmp/* /var/tmp/*

RUN mkdir -p /var/lib/mysql /var/run/mysqld \
  && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
  && chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/entrypoint.sh"]
