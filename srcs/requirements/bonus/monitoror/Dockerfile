FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN groupadd --system --gid 999 monitoror \
  && useradd --system --gid monitoror --uid 999 monitoror \
  && apt update && apt install -y curl \
  && curl -sSL --output /usr/local/bin/monitoror https://github.com/monitoror/monitoror/releases/download/4.0.1/monitoror-linux-amd64-4.0.1 \
  && chown monitoror:monitoror /usr/local/bin/monitoror \
  && chmod 750 /usr/local/bin/monitoror

COPY ./conf/config.json /etc/monitoror/config.json

RUN chown monitoror:monitoror /etc/monitoror/config.json && chmod 640 /etc/monitoror/config.json

USER monitoror
EXPOSE 8080

ENTRYPOINT ["monitoror"]
