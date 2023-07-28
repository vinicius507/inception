COMPOSE_FILE=./srcs/docker-compose.yaml

all: up

up: docker-networks docker-volumes
	sudo docker-compose -f $(COMPOSE_FILE) up -d

down:
	sudo docker-compose -f $(COMPOSE_FILE) down

build:
	sudo docker-compose -f $(COMPOSE_FILE) build --no-cache

clean:
	sudo docker-compose -f $(COMPOSE_FILE) down --rmi all --remove-orphans

fclean: clean
	docker network rm inception-network
	docker volume rm mariadb-data

re: fclean all

docker-networks:
	docker network create --driver bridge inception-network 2>&1 &>/dev/null || true

docker-volumes:
	docker volume create mariadb-data

.PHONY: all up down build clean fclean re docker-networks docker-volumes
