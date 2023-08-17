# Inception
This repository contains my Inception project at 42 School. The project focuses on gaining hands-on experience with Docker and Docker Compose while setting up and orchestrating a collection of services.

The project involves implementing the following services:

- **MariaDB Server (Mandatory):** This service provides the database backend for a Wordpress website.
- **Wordpress Website (Mandatory):** The main website is built using Wordpress, allowing for dynamic content management.
- **Nginx Reverse Proxy (Mandatory):** Nginx is used as a reverse proxy to efficiently route and manage incoming web traffic.
- **Redis Cache Server (Bonus):** A Redis cache server is included to enhance data caching and retrieval for Wordpress using the Redis Object Cache plugin.
- **Static Website (Bonus):** The inclusion of a static website (a canvas which renders a Mandelbrot Set visualization).
- **FTP Server (Bonus):** An FTP server (vsftpd) is configured for file transfer needs, enhancing project versatility.
- **Additional Useful Service (Bonus):** The project incorporates Monitoror, an essential service for monitoring and displaying the status for each service.

## Requirements
> **Warning**
>
> This project is meant to be executed on a 42 School Virtual Machine.

- Docker
- Docker Compose
- GNU Make

## Usage
To get started, simply run `make` at the project root:

```sh
$ make
```

This command will add the entry `127.0.0.1 vgoncalv.42.fr` to `/etc/hosts`, while building and starting each container with `docker-compose`.

To access each service inside the VM:

- Wordpress: `https://vgoncalv.42.fr`
- Adminer: `https://vgoncalv.42.fr/adminer`
- Static Website (Mandelbrot Canvas): `https://vgoncalv.42.fr/website`
- Monitoror: `https://vgoncalv.42.fr/monitoror`
- vsftpd: `ftp://vgoncalv.42.fr`

## Architecture
The project has the following architecture:

- Each container can be gracefully shut down using the `docker-compose` CLI.
- Each container can communicate with each other using the `inception` network.
- Each container has a healthy check to ensure correct container initialization.
- The containers that require volumes have them mounted at `/home/vgoncalv/data` inside the VM.
- Use TLS v1.2 or v1.3 on `nginx` with `openssl` self-signed certificates.
- Use `nginx` as a reverse proxy for the following services (containers):
  - Wordpress using `php-fpm` on port `9000`
  - Adminer using `php-fpm` on port `8000`
  - Proxy pass for an `nginx` server serving a static website on port `8081`
  - Proxy pass for a `monitoror` instance, with status checks for all services on port `8080`
