FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl nginx

COPY ./conf/www/static-website /var/www/static-website

RUN chown -R www-data:www-data /var/www/static-website \
  && chmod 755 /var/www/static-website \
  && find /var/www/static-website -type f -exec chmod 644 {} \;

COPY ./conf/vgoncalv.42.fr-static-website /etc/nginx/sites-available/vgoncalv.42.fr-static-website
RUN ln -s /etc/nginx/sites-available/vgoncalv.42.fr-static-website /etc/nginx/sites-enabled/vgoncalv.42.fr-static-website

EXPOSE 8081

STOPSIGNAL SIGQUIT

ENTRYPOINT ["nginx", "-g", "daemon off;"]
