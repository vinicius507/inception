FROM debian:bullseye

RUN apt update && apt install redis -y

COPY ./conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

ENTRYPOINT ["redis-server", "/etc/redis/redis.conf"]
