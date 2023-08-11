COMPOSE_FILE=./srcs/docker-compose.yaml

all: up

up: hostname docker-mounts
	sudo docker-compose -f $(COMPOSE_FILE) up -d

debug: hostname docker-mounts
	sudo docker-compose -f $(COMPOSE_FILE) up

down:
	sudo docker-compose -f $(COMPOSE_FILE) down

build:
	sudo docker-compose -f $(COMPOSE_FILE) build --no-cache

clean:
	sudo docker-compose -f $(COMPOSE_FILE) down --rmi all --remove-orphans

fclean: clean
	sudo rm -rf /home/vgoncalv/data
	sudo sed -in '/127.0.0.1 vgoncalv.42.fr/d' /etc/hosts

re: fclean all

docker-mounts:
	sudo mkdir -p /home/vgoncalv/data/mariadb
	sudo mkdir -p /home/vgoncalv/data/wordpress
	sudo mkdir -p /home/vgoncalv/data/adminer

hostname:
	grep -q "vgoncalv.42.fr" /etc/hosts || echo "127.0.0.1 vgoncalv.42.fr" | sudo tee -a /etc/hosts

.PHONY: all up debug down build clean fclean re docker-mounts
