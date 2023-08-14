FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl

RUN curl -sSL \
      --output /usr/local/bin/monitoror \
      https://github.com/monitoror/monitoror/releases/download/4.0.1/monitoror-linux-amd64-4.0.1 \
  && chmod +x /usr/local/bin/monitoror

COPY ./conf/config.json /etc/monitoror/config.json

EXPOSE 8080

ENTRYPOINT ["monitoror"]
