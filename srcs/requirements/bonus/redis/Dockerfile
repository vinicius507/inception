FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install redis -y

COPY ./conf/redis.conf /etc/redis/redis.conf
RUN chown redis:redis /etc/redis/redis.conf && chmod 640 /etc/redis/redis.conf

USER redis
EXPOSE 6379

ENTRYPOINT ["redis-server", "/etc/redis/redis.conf"]
