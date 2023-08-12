FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y iproute2 vsftpd

ARG FTP_USER
RUN useradd --create-home $FTP_USER \
  && usermod --append --groups www-data $FTP_USER \
  && echo "$FTP_USER" > /etc/vsftpd.userlist

ARG FTP_PATH
COPY ./conf/vsftpd.conf /etc/vsftpd.conf
RUN echo "local_root=$FTP_PATH" >> /etc/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty

COPY ./tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 20 21 21100-21110

ENTRYPOINT ["/entrypoint.sh"]
