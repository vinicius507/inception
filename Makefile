COMPOSE_FILE=./srcs/docker-compose.yaml

all: up

up: docker-networks docker-mounts
	sudo docker-compose -f $(COMPOSE_FILE) up -d

debug: docker-networks docker-mounts
	sudo docker-compose -f $(COMPOSE_FILE) up

down:
	sudo docker-compose -f $(COMPOSE_FILE) down

build:
	sudo docker-compose -f $(COMPOSE_FILE) build --no-cache

clean:
	sudo docker-compose -f $(COMPOSE_FILE) down --rmi all --remove-orphans

fclean: clean
	docker network rm inception-network
	sudo rm -rf /home/vgoncalv/data

re: fclean all

docker-networks:
	docker network create --driver bridge inception-network 2>&1 &>/dev/null || true

docker-mounts:
	sudo mkdir -p /home/vgoncalv/data/mariadb
	sudo mkdir -p /home/vgoncalv/data/wordpress
	sudo chown user42:user42 -R /home/vgoncalv

.PHONY: all up debug down build clean fclean re docker-networks docker-mounts
