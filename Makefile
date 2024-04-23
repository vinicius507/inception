DATA_DIR ?= ./data
COMPOSE_FLAGS = -f ./srcs/docker-compose.yaml

all: up

up: hostname docker-mounts
	sudo docker compose ${COMPOSE_FLAGS} up -d

debug: hostname docker-mounts
	sudo docker compose ${COMPOSE_FLAGS} up --build

down:
	sudo docker compose ${COMPOSE_FLAGS} down

build:
	sudo docker compose ${COMPOSE_FLAGS} build --no-cache

clean:
	sudo docker compose ${COMPOSE_FLAGS} down --rmi all --remove-orphans

fclean: clean
	sudo rm -rf /home/vgoncalv/data
	sudo sed -in '/127.0.0.1 vgoncalv.42.fr/d' /etc/hosts

re: fclean all

docker-mounts:
	sudo mkdir -p ${DATA_DIR}/mariadb
	sudo mkdir -p ${DATA_DIR}/wordpress
	sudo mkdir -p ${DATA_DIR}/adminer

hostname:
	grep -q "vgoncalv.42.fr" /etc/hosts || echo "127.0.0.1 vgoncalv.42.fr" | sudo tee -a /etc/hosts

.PHONY: all up debug down build clean fclean re docker-mounts
