#!/bin/bash

echo "$FTP_USER:$FTP_PWD" | chpasswd

exec vsftpd /etc/vsftpd.conf
