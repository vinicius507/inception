FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl openssl nginx

ARG DOMAIN_NAME
RUN openssl req -x509 -nodes -days 365 \
  -subj "/C=BR/ST=PB/O=42/CN=$DOMAIN_NAME" \
  -addext "subjectAltName=DNS:$DOMAIN_NAME" \
  -newkey rsa:2048 -keyout /etc/ssl/private/inception-selfsigned.key \
  -out /etc/ssl/certs/inception-selfsigned.crt

COPY ./conf/vgoncalv.42.fr /etc/nginx/sites-available/vgoncalv.42.fr
RUN ln -s /etc/nginx/sites-available/vgoncalv.42.fr /etc/nginx/sites-enabled/vgoncalv.42.fr

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
