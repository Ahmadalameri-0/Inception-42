NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean:	clean
	docker system prune -af --volumes
	docker compose -f srcs/docker-compose.yml down -v --rmi all
	sudo rm -rf /home/ahmadlameri/data/mariadb
	sudo rm -rf /home/ahmadlameri/data/wordpress
	mkdir -p /home/ahmadlameri/data/mariadb
	mkdir -p /home/ahmadlameri/data/wordpress

re: fclean all

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

.PHONY: all up down clean fclean re logs ps